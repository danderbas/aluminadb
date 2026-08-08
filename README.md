# aluminadb

Data model + ETL (extract, transform, load) pipeline for production management of an aluminum profile manufacturing plant

```mermaid
flowchart LR
  sheet(["Data<br/>sheets"])

  sheet --> macro
  subgraph extract_box["Extract"]
    direction LR
    macro["Export"]
    csv[("CSV<br/>files")]
    macro --> csv
  end

  subgraph transform_box["Transform"]
    direction LR
    clean["Cleanup"]
  end

  subgraph load_box["Load"]
    direction LR
    load["DB<br/>Load"]
    staging[("Staging<br/>tables")]
    validate["Validation"]
    load --> staging --> validate 
  end

  core[("Core<br/>tables")]
  load --> core
  validate --> core
  csv --> clean --> load
```

## What this is

This repo contains code for a self-made system built to replace manual spreadsheet processing in an aluminum profile (manufacturing) plant, where 2 main processes took place: extrusion and (electrostatic) painting|coating.

```mermaid
flowchart LR
  billet(["Raw<br/>billet"])
  billet --> billetprep

  subgraph extrusion_box["Extrusion"]
    direction TB
    
    billetprep["Billet<br/>prep"]

    pressing["Press"]
    stretching["Stretch"]

    aging["Age"]
    billetprep --> pressing --> stretching --> aging
  end
  profile(["Raw<br/>aluminum<br/>profile"])

  aging --> profile

  subgraph painting_box["Painting|Coating"]
    direction LR
    surfaceprep["Surface<br/>prep"]
    coating["Electrostatic<br/>coat"]
    curing["Bake"]
    surfaceprep --> coating --> curing
  end

  coatedprofile(["Coated<br/>aluminum<br/>profile"])
  curing --> coatedprofile

  profile --> surfaceprep

  stock["Stock"]
  delivery(["Customer<br/>Supply"])
  profile --> stock
  coatedprofile --> stock
  stock --> delivery

  %%profile --> paintprep
```

It was built to better track production, deliver orders and generate reports.

*Fun fact: `alumina` (aka Aluminum Oxide, Al2O3) is what covers raw aluminum: since it is very reactive with atmospheric oxygen in its pure form, a thin oxide layer forms on exposed aluminum surfaces almost instantly, which protects the metal from further oxidation.*

It ran in daily production from late 2018 to mid 2020 (about a year and a half), until I left the company.

More information on the industrial process [here](./docs/industrial_process.md).

## Quick start

```bash
docker compose up -d
bash src/bash/do.sh          # Set up the schema
bash src/bash/doloaddata.sh  # Load the CSV data
```

## Tech stack

It was written in Bash and MySQL, originally running against a MySQL server on a Linux machine.

**Why?** *Bash and MySQL were what I already knew at the time, not an architectural choice I'd defend today.*

It can now be run and tested locally through the included Docker Compose (v2) service (MySQL 8.0 in a container). Bash (>= 4) is used for setting up the schema and loading data into the database.

## How it works

The system is accessed directly via a MySQL client, querying views for the most part.

```mermaid
flowchart LR
    sheet(["LibreOffice sheet"])
    macro["Export macro"]
    csv[("CSV files")]
    clean["Null cleanup<br/>(strip quoted NULL)"]
    load["LOAD DATA"]
    staging[("Staging table<br/>(s_*)")]
    validate["Validation"]
    core[("Core table")]

    sheet --> macro --> csv --> clean --> load
    load -->|most tables| core
    load -->|tables needing<br/>cross-checks| staging --> validate --> core
```

((add here asciinema example and a link to the script so the user can run try running it --- also... there should be a docker service for bash + the mysql client, in case the user doent have it))

Note: there really wasn't much sophisticated validation going on at the time. Typos or mismatches (a wrong or missing key, for example) simply failed to load, MySQL rejected the row, the source spreadsheet was fixed, and it got reloaded. The staging-table step (`s_*` to validate to core) is the one deliberate exception, for a handful of tables where a row needed a cross-check before being trusted (other than just a valid foreign key).

## Capabilities

Despite being just tables, views, and a few stored procedures — no app layer, no dashboard — it
covered a useful range of real, critical production needs:

- **Production planning** — decide what to extrude today, in what order, with how much material
- **Die management** — know which dies need nitriding before it's a problem, catch wear early
- **Inventory** — real stock counts, in units and kg, for raw profile and paint
- **Yield reporting** — actual vs. target, per run, per day, per month, on demand
- **Traceability** — a finished, aged basket of profile traced back through its extrusion runs to the raw aluminum delivery it came from (down to the mill's own heat number), or any paint box back to its supplier and batch — and any of it back to the worker who handled it
- **Order management** — one live view of what's open, shipped, and still owed

Full list: [docs/capabilities.md](./docs/capabilities.md)

## Schema

67 tables, 108 foreign keys, 30 views: 877 order line items and roughly 22K rows loaded in total, tracking hundreds of extrusion and painting runs.

```mermaid
flowchart BT
  subgraph extrusion_chain[" "]
    direction BT
    generacion_op_extrusion["<b>generacion_op_extrusion</b><br/>int nro_op PK<br/>date fecha<br/>int id_rrhh FK"]
    op_extrusion["<b>op_extrusion</b><br/>int nro_op PK,FK<br/>int nro_subop PK<br/>varchar cod_perfil FK<br/>decimal long_perfil__m<br/>int cant_perfil_min<br/>int id_estado"]
    op_extrusion_entrada["<b>op_extrusion_entrada</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>decimal long_tocho__cm PK<br/>int cant_tochos<br/>int cant_tochosporcorte<br/>float posicion_sierracorte<br/>int id_proveedor_aluminio FK"]
    op_extrusion_matriz["<b>op_extrusion_matriz</b><br/>int nro_op FK<br/>int nro_subop FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK"]
    op_extrusion_objetivo["<b>op_extrusion_objetivo</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>float long_mesa_objetivo__m<br/>int cant_perfil_objetivo<br/>float salida_objetivo__kg"]
    op_extrusion_parapedido["<b>op_extrusion_parapedido</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>int nro_pedido PK,FK<br/>int nro_subpedido PK,FK"]
    op_extrusion_planeamiento["<b>op_extrusion_planeamiento</b><br/>int nro_op FK<br/>int nro_subop FK<br/>float fraccion_entrada<br/>date fecha_planeada<br/>int orden"]
    s_op_extrusion_matriz["<b>s_op_extrusion_matriz</b><br/>int nro_op FK<br/>int nro_subop FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK<br/>tinyint OK"]
    s_op_extrusion_parapedido["<b>s_op_extrusion_parapedido</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>int nro_pedido PK,FK<br/>int nro_subpedido PK,FK<br/>tinyint OK"]
    cortetochos["<b>cortetochos</b><br/>int nro PK<br/>int nro_op FK<br/>int nro_subop FK<br/>date fecha<br/>time hora_inicio<br/>time hora_fin<br/>int id_rrhh FK<br/>int nro_tocho0 FK<br/>decimal long_inicial__cm<br/>decimal long_tocho__cm<br/>int cant_tochos<br/>float pesoprom_tochos__kg<br/>decimal long_final__cm<br/>float peso_resto__kg"]
    extrusion["<b>extrusion</b><br/>int nro PK<br/>date fecha<br/>time hora_inicio<br/>time hora_fin<br/>int id_rrhh FK<br/>int nro_op FK<br/>int nro_subop FK<br/>varchar cod_perfil FK"]
    extrusion_corte["<b>extrusion_corte</b><br/>int nro_extrusion FK<br/>date fecha<br/>time hora_inicio<br/>time hora_fin<br/>int id_rrhh_1 FK<br/>int id_rrhh_2 FK"]
    extrusion_entrada["<b>extrusion_entrada</b><br/>int nro_extrusion PK,FK<br/>decimal long_tocho__cm PK<br/>float peso_unit__kg<br/>int cantidad"]
    extrusion_matriz["<b>extrusion_matriz</b><br/>int nro_extrusion PK,FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK"]
    extrusion_muestraculote["<b>extrusion_muestraculote</b><br/>int nro_extrusion FK<br/>int cant_culote<br/>float peso_total__kg"]
    extrusion_muestraperfil["<b>extrusion_muestraperfil</b><br/>int nro_extrusion FK<br/>int nro_salida<br/>decimal long_muestraperfil__cm<br/>float peso_muestra__g"]
    extrusion_salida["<b>extrusion_salida</b><br/>int nro_extrusion FK<br/>decimal long_perfil__m<br/>int cantidad<br/>int id_tipo_contenedor FK<br/>int id_contenedor FK"]
    extrusion_stats["<b>extrusion_stats</b><br/>int nro_extrusion PK,FK<br/>tinyint es_prueba<br/>float pos_sierracorte<br/>float long_mesa__m<br/>float temp_tocho_entrada__c<br/>float temp_perfil_salida__c<br/>tinyint sugiere_correccion_matriz<br/>tinyint extrusion_detenida<br/>text comentarios"]
    s_extrusion["<b>s_extrusion</b><br/>int nro PK<br/>date fecha<br/>time hora_inicio<br/>time hora_fin<br/>int id_rrhh FK<br/>int nro_op FK<br/>int nro_subop FK<br/>varchar cod_perfil FK<br/>tinyint OK"]
    s_extrusion_matriz["<b>s_extrusion_matriz</b><br/>int nro_extrusion PK,FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK<br/>tinyint OK"]
    envejecimiento["<b>envejecimiento</b><br/>int nro PK<br/>date fecha_inicio<br/>time hora_inicio<br/>int id_rrhh_inicio FK<br/>date fecha_fin<br/>time hora_fin<br/>int id_rrhh_fin FK"]
    envejecimiento_canastos["<b>envejecimiento_canastos</b><br/>int nro_canasto<br/>int nro_envejecimiento FK<br/>int id_tipo_contenedor FK<br/>int id_contenedor FK"]
    cortetocho_pesoprom_v(["cortetocho_pesoprom_v"])
    ope_v(["ope_v"])
    plan_extrusion_sinpeso_v(["plan_extrusion_sinpeso_v"])
    plan_extrusion_v(["plan_extrusion_v"])
    extrusion_kgentradatotal_v(["extrusion_kgentradatotal_v"])
    extrusion_pesolineal_v(["extrusion_pesolineal_v"])
    extrusion_long_salida_v(["extrusion_long_salida_v"])
    extrusion_kgsalidatotal_v(["extrusion_kgsalidatotal_v"])
    extrusion_entradasalidatotal_v(["extrusion_entradasalidatotal_v"])
    extrusion_entsaltot_v(["extrusion_entsaltot_v"])
    extrusion_entsaltotobj_v(["extrusion_entsaltotobj_v"])
    extrusion_v(["extrusion_v"])
    extrusion_pordia_v(["extrusion_pordia_v"])
    extrusion_pormesano_v(["extrusion_pormesano_v"])
    extrusion_total_v(["extrusion_total_v"])
    extrusion_entsaltot_pordia_v(["extrusion_entsaltot_pordia_v"])
    extrusion_entsaltot_pormesano_v(["extrusion_entsaltot_pormesano_v"])
    envejecimiento_canastos_detalle["<b>envejecimiento_canastos_detalle</b><br/>int nro_canasto FK<br/>varchar cod_perfil FK<br/>decimal long_perfil__m<br/>int cantidad<br/>int nro_op FK<br/>int nro_subop FK"]
  end
  subgraph extrusion_refs[" "]
    direction BT
    tocho0["<b>tocho0</b><br/>int nro PK<br/>int nro_carga FK<br/>int nro_bulto FK"]
    cargas_aluminio["<b>cargas_aluminio</b><br/>int nro_carga PK<br/>int id_proveedor_aluminio FK<br/>date fecha_recepcion"]
    cargas_aluminio_detalle["<b>cargas_aluminio_detalle</b><br/>int nro_carga PK,FK<br/>int nro_bulto PK<br/>varchar nro_produccion<br/>varchar aleacion<br/>int cant_tocho0<br/>decimal long_tocho0__cm<br/>float peso_neto__kg<br/>float peso_bruto__kg"]
    matrices["<b>matrices</b><br/>varchar codigo PK<br/>int id_tipo FK<br/>varchar cod_perfil FK<br/>int nro_salidas<br/>int id_proveedor<br/>tinyint es_fragil"]
    matrices_correccion["<b>matrices_correccion</b><br/>int fecha<br/>int id_rrhh FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK<br/>text descripcion"]
    matrices_mediciondureza["<b>matrices_mediciondureza</b><br/>date fecha<br/>int id_rrhh FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK<br/>float dureza__rhc"]
    matrices_nitruracion["<b>matrices_nitruracion</b><br/>date fecha_salida<br/>date fecha_retorno<br/>int id_rrhh_salida FK<br/>int id_rrhh_retorno FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK"]
    nitruracion_kgmax["<b>nitruracion_kgmax</b><br/>int nro_nitruraciones PK<br/>tinyint es_fragil PK<br/>float max__kg PK"]
    stock_matrices["<b>stock_matrices</b><br/>varchar cod_matriz PK,FK<br/>int nro_serie PK<br/>varchar grabado"]
    tipos_matrices["<b>tipos_matrices</b><br/>int id PK<br/>char descripcion"]
    perfiles["<b>perfiles</b><br/>varchar codigo PK<br/>varchar descripcion<br/>int id_tipo FK<br/>float pesolinealnominal__kg_m<br/>float perimetro__mm<br/>float area__mm2<br/>varchar codigo_externo<br/>tinyint es_extrusable"]
    tipos_perfiles["<b>tipos_perfiles</b><br/>int id PK<br/>char descripcion"]
    stock_contenedores_perfiles["<b>stock_contenedores_perfiles</b><br/>int id_tipo_contenedor PK,FK<br/>int id_contenedor PK"]
    tipos_contenedores_perfiles["<b>tipos_contenedores_perfiles</b><br/>int id PK<br/>char descripcion<br/>char abreviatura"]
    stock_perfiles_nat_resumen_conpesoydesc_v(["stock_perfiles_nat_resumen_conpesoydesc_v"])
    extrusion_matriz_kgextruidos_v(["extrusion_matriz_kgextruidos_v"])
    matrices_hojadevida_v(["matrices_hojadevida_v"])
    matrices_ultnit_v(["matrices_ultnit_v"])
    matrices_ultnitkg_v(["matrices_ultnitkg_v"])
    matrices_nitruracion_v(["matrices_nitruracion_v"])
    matrices_nitruracion_vv(["matrices_nitruracion_vv"])
    d_stock_perfiles["<b>d_stock_perfiles</b><br/>int id PK<br/>date fecha<br/>time hora<br/>int id_rrhh FK<br/>int id_tipo_contenedor_origen FK<br/>int id_contenedor_origen FK<br/>int id_tipo_contenedor_destino FK<br/>int id_contenedor_destino FK<br/>varchar cod_perfil FK<br/>decimal long_perfil__m<br/>tinyint es_envejecido<br/>int id_tipo_acabado FK<br/>int id_color FK<br/>tinyint es_defectuoso<br/>int cantidad<br/>int nro_extrusion FK<br/>int nro_envejecimiento FK<br/>int nro_pintura FK<br/>int id_impresion_etiq<br/>varchar comentario<br/>tinyint es_fix<br/>tinyint OK"]
    stock_perfiles["<b>stock_perfiles</b><br/>int id_tipo_contenedor PK,FK<br/>int id_contenedor PK,FK<br/>varchar cod_perfil PK,FK<br/>decimal long_perfil__m PK<br/>tinyint es_envejecido PK<br/>int id_tipo_acabado PK,FK<br/>int id_color PK,FK<br/>tinyint es_defectuoso PK<br/>int cantidad"]
    stock_perfiles_nat_resumen_v(["stock_perfiles_nat_resumen_v"])
    stock_perfiles_nat_resumen_conpesoydesc_v(["stock_perfiles_nat_resumen_conpesoydesc_v"])
  end
  subgraph customer_cluster[" "]
    direction BT
    clientes["<b>clientes</b><br/>int id PK<br/>varchar usuario FK<br/>int id_organizacion FK<br/>varchar nombre<br/>varchar apellido<br/>varchar email<br/>int telefono"]
    org_clientes["<b>org_clientes</b><br/>int id PK<br/>varchar descripcion<br/>int telefono<br/>int telefono2<br/>varchar direccion<br/>varchar ubicacion"]
    usuarios["<b>usuarios</b><br/>varchar id PK<br/>varchar clave<br/>tinyint es_rrhh<br/>tinyint es_cliente<br/>tinyint es_delgrupo<br/>tinyint es_admin"]
  end
  subgraph pedidos_cluster[" "]
    direction BT
    estados_pedidos["<b>estados_pedidos</b><br/>int id PK<br/>varchar descripcion"]
    generacion_pedidos["<b>generacion_pedidos</b><br/>int nro_pedido PK<br/>int id_cliente FK<br/>int id_rrhh FK<br/>date fecha_recepcion<br/>time hora_recepcion<br/>varchar id_pedido_seguncliente<br/>varchar obra_uso<br/>text comentarios"]
    pedidos["<b>pedidos</b><br/>int nro_pedido PK,FK<br/>int nro_subpedido PK<br/>int id_tipo_pedido FK<br/>tinyint es_recibidoparapintar<br/>varchar codigo FK<br/>decimal long__m<br/>int id_tipo_acabado FK<br/>int id_color FK<br/>float cantidad<br/>int id_prioridad<br/>int id_estado FK"]
    pedidos_expedicion["<b>pedidos_expedicion</b><br/>int nro_pedido FK<br/>int nro_subpedido FK<br/>date fecha<br/>time hora<br/>int cant_perfiles"]
    tipos_acabado["<b>tipos_acabado</b><br/>int id PK<br/>char descripcion"]
    tipos_pedidos["<b>tipos_pedidos</b><br/>int id PK<br/>char descripcion<br/>varchar unidad"]
    pedidos_v(["pedidos_v"])
    pedidos_expedicion_v(["pedidos_expedicion_v"])
    pedidos_pendientes_v(["pedidos_pendientes_v"])
    pedidos_pendientes_resumen_v(["pedidos_pendientes_resumen_v"])
  end
  subgraph central_shared[" "]
    direction BT
    rrhh["<b>rrhh</b><br/>int id PK<br/>int id_estado<br/>int nivel<br/>varchar usuario FK<br/>varchar nombre<br/>varchar apellido<br/>int ci<br/>date fecha_nacimiento<br/>varchar direccion<br/>varchar ubicacion<br/>varchar barrio<br/>varchar ciudad<br/>varchar nro_celular<br/>varchar nro_contactourgencia<br/>varchar relacion_contactourgencia<br/>int id_marcador"]
    proveedores["<b>proveedores</b><br/>int id PK<br/>varchar descripcion<br/>int id_tipo FK<br/>text otros_datos"]
    tipos_proveedores["<b>tipos_proveedores</b><br/>int id PK<br/>varchar descripcion"]
  end
  subgraph painting_refs[" "]
    direction BT
    cargas_pinturas["<b>cargas_pinturas</b><br/>int nro_carga PK<br/>int id_proveedor_pintura<br/>date fecha_recepcion<br/>int nro_remision<br/>int nro_factura<br/>text comentarios"]
    cargas_pinturas_detalle["<b>cargas_pinturas_detalle</b><br/>int nro_carga PK,FK<br/>int nro_subcarga PK<br/>varchar cod_pintura_proveedor FK<br/>varchar lote<br/>date fecha_elaboracion<br/>date fecha_vencimiento"]
    pinturas["<b>pinturas</b><br/>int nro_caja PK<br/>int nro_carga FK<br/>int nro_subcarga FK"]
    colores["<b>colores</b><br/>int id PK<br/>char abreviatura<br/>char descripcion"]
    colores_codigos["<b>colores_codigos</b><br/>varchar cod_pintura_proveedor PK<br/>varchar desc_proveedor<br/>int id_color FK<br/>int id_proveedor PK,FK<br/>int id_marca FK"]
    marcas["<b>marcas</b><br/>int id PK<br/>varchar descripcion"]
    cajas_pinturas_v(["cajas_pinturas_v"])
    d_stock_pinturas["<b>d_stock_pinturas</b><br/>int id PK<br/>date fecha<br/>time hora<br/>int id_rrhh FK<br/>int nro_caja FK<br/>int d_cantidad<br/>int nro_pedidointerno<br/>tinyint es_fix<br/>tinyint OK"]
    stock_pinturas["<b>stock_pinturas</b><br/>int nro_caja FK"]
  end
  subgraph painting_chain[" "]
    direction BT
    estados_op_pintura["<b>estados_op_pintura</b><br/>int id PK<br/>varchar descripcion"]
    generacion_op_pintura["<b>generacion_op_pintura</b><br/>int nro_op PK<br/>int id_color FK<br/>date fecha<br/>int id_rrhh FK"]
    op_pintura["<b>op_pintura</b><br/>int nro_op PK,FK<br/>int nro_subop PK<br/>varchar codigo FK<br/>decimal long__m<br/>int cantidad<br/>int id_estado FK"]
    op_pintura_parapedido["<b>op_pintura_parapedido</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>int nro_pedido PK,FK<br/>int nro_subpedido PK,FK"]
    op_pintura_planeamiento["<b>op_pintura_planeamiento</b><br/>int nro_op FK<br/>int nro_subop FK<br/>float fraccion_entrada<br/>date fecha_planeada<br/>int orden"]
    s_op_pintura_parapedido["<b>s_op_pintura_parapedido</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>int nro_pedido PK,FK<br/>int nro_subpedido PK,FK<br/>tinyint OK"]
    pintura["<b>pintura</b><br/>int nro PK<br/>int nro_op<br/>int nro_subop<br/>int id_color FK<br/>date fecha<br/>time hora_inicio<br/>time hora_fin<br/>int id_rrhh FK<br/>float velocidad_monovia<br/>int cant_porganchera<br/>varchar codigo<br/>float long__m<br/>int cantidad"]
    s_pintura["<b>s_pintura</b><br/>int nro PK<br/>int nro_op<br/>int nro_subop<br/>int id_color FK<br/>date fecha<br/>time hora_inicio<br/>time hora_fin<br/>int id_rrhh FK<br/>float velocidad_monovia<br/>int cant_porganchera<br/>varchar codigo<br/>float long__m<br/>int cantidad<br/>tinyint OK"]
  end

  clientes -->|"as user"| usuarios
  clientes -->|"belongs to org"| org_clientes
  rrhh -->|"as user"| usuarios
  cargas_aluminio -->|"supplied by"| proveedores
  cargas_aluminio_detalle -->|"from load"| cargas_aluminio
  cargas_pinturas_detalle -->|"from load"| cargas_pinturas
  cargas_pinturas_detalle -->|"of paint code"| colores_codigos
  colores_codigos -->|"in color"| colores
  colores_codigos -->|"supplied by"| proveedores
  colores_codigos -->|"of brand"| marcas
  pinturas -->|"from load"| cargas_pinturas_detalle
  proveedores -->|"is type"| tipos_proveedores
  stock_contenedores_perfiles -->|"in container type"| tipos_contenedores_perfiles
  tocho0 -->|"from load"| cargas_aluminio_detalle
  matrices -->|"is type"| tipos_matrices
  matrices -->|"of profile"| perfiles
  matrices_correccion -->|"using die"| stock_matrices
  matrices_correccion -->|"recorded by"| rrhh
  matrices_mediciondureza -->|"using die"| stock_matrices
  matrices_mediciondureza -->|"recorded by"| rrhh
  matrices_nitruracion -->|"using die"| stock_matrices
  matrices_nitruracion -->|"sent out by"| rrhh
  matrices_nitruracion -->|"returned by"| rrhh
  perfiles -->|"is type"| tipos_perfiles
  stock_matrices -->|"using die"| matrices
  generacion_pedidos -->|"recorded by"| rrhh
  generacion_pedidos -->|"requested by"| clientes
  pedidos -->|"for order"| generacion_pedidos
  pedidos -->|"of profile"| perfiles
  pedidos -->|"is type"| tipos_pedidos
  pedidos -->|"has finish"| tipos_acabado
  pedidos -->|"in color"| colores
  pedidos -->|"has status"| estados_pedidos
  pedidos_expedicion -->|"for order"| pedidos
  generacion_op_extrusion -->|"recorded by"| rrhh
  op_extrusion -->|"for op"| generacion_op_extrusion
  op_extrusion -->|"of profile"| perfiles
  op_extrusion_entrada -->|"for op"| op_extrusion
  op_extrusion_entrada -->|"supplied by"| proveedores
  op_extrusion_matriz -->|"for op"| op_extrusion
  op_extrusion_matriz -->|"using die"| stock_matrices
  op_extrusion_objetivo -->|"for op"| op_extrusion
  op_extrusion_parapedido -->|"for op"| op_extrusion
  op_extrusion_parapedido -->|"for order"| pedidos
  op_extrusion_planeamiento -->|"for op"| op_extrusion
  s_op_extrusion_matriz -->|"for op"| op_extrusion
  s_op_extrusion_matriz -->|"using die"| stock_matrices
  s_op_extrusion_parapedido -->|"for op"| op_extrusion
  s_op_extrusion_parapedido -->|"for order"| pedidos
  generacion_op_pintura -->|"in color"| colores
  generacion_op_pintura -->|"recorded by"| rrhh
  op_pintura -->|"for op"| generacion_op_pintura
  op_pintura -->|"of profile"| perfiles
  op_pintura -->|"has status"| estados_op_pintura
  op_pintura_parapedido -->|"for op"| op_pintura
  op_pintura_parapedido -->|"for order"| pedidos
  op_pintura_planeamiento -->|"for op"| op_pintura
  s_op_pintura_parapedido -->|"for op"| op_pintura
  s_op_pintura_parapedido -->|"for order"| pedidos
  cortetochos -->|"of billet"| tocho0
  cortetochos -->|"for op"| op_extrusion
  cortetochos -->|"recorded by"| rrhh
  extrusion -->|"of profile"| perfiles
  extrusion -->|"for op"| op_extrusion
  extrusion -->|"recorded by"| rrhh
  extrusion_corte -->|"from extrusion"| extrusion
  extrusion_corte -->|"cut by (operator 1)"| rrhh
  extrusion_corte -->|"cut by (operator 2)"| rrhh
  extrusion_entrada -->|"from extrusion"| extrusion
  extrusion_matriz -->|"from extrusion"| extrusion
  extrusion_matriz -->|"using die"| stock_matrices
  extrusion_muestraculote -->|"from extrusion"| extrusion
  extrusion_muestraperfil -->|"from extrusion"| extrusion
  extrusion_salida -->|"from extrusion"| extrusion
  extrusion_salida -->|"in container type"| stock_contenedores_perfiles
  extrusion_stats -->|"from extrusion"| extrusion
  s_extrusion -->|"of profile"| perfiles
  s_extrusion -->|"for op"| op_extrusion
  s_extrusion -->|"recorded by"| rrhh
  s_extrusion_matriz -->|"from extrusion"| extrusion
  s_extrusion_matriz -->|"using die"| stock_matrices
  envejecimiento -->|"started by"| rrhh
  envejecimiento -->|"ended by"| rrhh
  envejecimiento_canastos -->|"from aging batch"| envejecimiento
  envejecimiento_canastos -->|"in container type"| stock_contenedores_perfiles
  pintura -->|"in color"| colores
  pintura -->|"recorded by"| rrhh
  s_pintura -->|"in color"| colores
  s_pintura -->|"recorded by"| rrhh

  d_stock_perfiles -->|"recorded by"| rrhh
  d_stock_perfiles -->|"from container"| stock_contenedores_perfiles
  d_stock_perfiles -->|"to container"| stock_contenedores_perfiles
  d_stock_perfiles -->|"of profile"| perfiles
  d_stock_perfiles -->|"has finish"| tipos_acabado
  d_stock_perfiles -->|"in color"| colores
  d_stock_perfiles -->|"from extrusion"| extrusion
  d_stock_perfiles -->|"from aging batch"| envejecimiento
  d_stock_perfiles -->|"from painting run"| pintura
  stock_perfiles -->|"in container"| stock_contenedores_perfiles
  stock_perfiles -->|"of profile"| perfiles
  stock_perfiles -->|"has finish"| tipos_acabado
  stock_perfiles -->|"in color"| colores
  d_stock_pinturas -->|"recorded by"| rrhh
  d_stock_pinturas -->|"of box"| pinturas
  stock_pinturas -->|"of box"| pinturas
  envejecimiento_canastos_detalle -->|"in basket"| envejecimiento_canastos
  envejecimiento_canastos_detalle -->|"of profile"| perfiles
  envejecimiento_canastos_detalle -->|"for op"| op_extrusion

  %% views
  cajas_pinturas_v --> cargas_pinturas
  cajas_pinturas_v --> cargas_pinturas_detalle
  cajas_pinturas_v --> colores
  cajas_pinturas_v --> colores_codigos
  cajas_pinturas_v --> pinturas
  cortetocho_pesoprom_v --> cortetochos
  extrusion_entradasalidatotal_v --> extrusion_kgentradatotal_v
  extrusion_entradasalidatotal_v --> extrusion_kgsalidatotal_v
  extrusion_entsaltot_pordia_v --> extrusion_entsaltot_v
  extrusion_entsaltot_pormesano_v --> extrusion_entsaltot_pordia_v
  extrusion_entsaltot_v --> extrusion
  extrusion_entsaltot_v --> extrusion_entradasalidatotal_v
  extrusion_entsaltotobj_v --> extrusion
  extrusion_entsaltotobj_v --> extrusion_salida
  extrusion_entsaltotobj_v --> op_extrusion
  extrusion_entsaltotobj_v --> extrusion_pesolineal_v
  extrusion_kgentradatotal_v --> extrusion_entrada
  extrusion_kgsalidatotal_v --> extrusion_long_salida_v
  extrusion_kgsalidatotal_v --> extrusion_pesolineal_v
  extrusion_long_salida_v --> extrusion_salida
  extrusion_matriz_kgextruidos_v --> extrusion
  extrusion_matriz_kgextruidos_v --> extrusion_matriz
  extrusion_matriz_kgextruidos_v --> extrusion_stats
  extrusion_matriz_kgextruidos_v --> extrusion_kgentradatotal_v
  extrusion_pesolineal_v --> extrusion_muestraperfil
  extrusion_pordia_v --> extrusion_v
  extrusion_pormesano_v --> extrusion_pordia_v
  extrusion_total_v --> extrusion_pormesano_v
  extrusion_v --> extrusion_entsaltot_v
  extrusion_v --> extrusion_entsaltotobj_v
  matrices_hojadevida_v --> matrices_correccion
  matrices_hojadevida_v --> matrices_mediciondureza
  matrices_hojadevida_v --> matrices_nitruracion
  matrices_hojadevida_v --> extrusion_matriz_kgextruidos_v
  matrices_nitruracion_v --> stock_matrices
  matrices_nitruracion_v --> matrices_ultnit_v
  matrices_nitruracion_v --> matrices_ultnitkg_v
  matrices_nitruracion_vv --> matrices_nitruracion_v
  matrices_ultnit_v --> matrices_nitruracion
  matrices_ultnitkg_v --> extrusion_matriz_kgextruidos_v
  matrices_ultnitkg_v --> matrices_ultnit_v
  ope_v --> op_extrusion
  ope_v --> op_extrusion_entrada
  pedidos_expedicion_v --> pedidos_expedicion
  pedidos_pendientes_resumen_v --> pedidos_pendientes_v
  pedidos_pendientes_v --> generacion_pedidos
  pedidos_pendientes_v --> pedidos
  pedidos_pendientes_v --> pedidos_expedicion_v
  pedidos_v --> clientes
  pedidos_v --> colores
  pedidos_v --> estados_pedidos
  pedidos_v --> generacion_pedidos
  pedidos_v --> org_clientes
  pedidos_v --> pedidos
  pedidos_v --> tipos_acabado
  pedidos_v --> tipos_pedidos
  plan_extrusion_sinpeso_v --> op_extrusion
  plan_extrusion_sinpeso_v --> op_extrusion_entrada
  plan_extrusion_sinpeso_v --> op_extrusion_planeamiento
  plan_extrusion_v --> cortetocho_pesoprom_v
  plan_extrusion_v --> plan_extrusion_sinpeso_v
  stock_perfiles_nat_resumen_conpesoydesc_v --> perfiles
  stock_perfiles_nat_resumen_v --> stock_perfiles
  stock_perfiles_nat_resumen_conpesoydesc_v --> stock_perfiles_nat_resumen_v
  stock_perfiles_nat_resumen_conpesoydesc_v --> perfiles

  style extrusion_chain fill:none,stroke:none
  style extrusion_refs fill:none,stroke:none
  style customer_cluster fill:none,stroke:none
  style pedidos_cluster fill:none,stroke:none
  style central_shared fill:none,stroke:none
  style painting_refs fill:none,stroke:none
  style painting_chain fill:none,stroke:none
```

For more detail, see:
- [Tables](./docs/schema/tables.md)
- [Views](./docs/schema/views.md)
- [Views Lineage](./docs/schema/views_lineage.md)
- [Procedures](./docs/schema/procedures.md)
- ERD ((TBD))


((link here the tables, views, views lineage, erds (should create just one... a final one that contains 'erd_all_grouped, view included, and then ordered sections for the details))

## Evolution

It was built incrementally and iteratively:

- It began with the design of the production log sheets (filled by the operators on the factory floor)
- Then the logs were transcribed into ~~Excel~~ LibreOffice Calc sheets (done by an assistant)

*There was no production management system in place yet: this was a brand new manufacturing plant, the company had already invested heavily in industrial equipment, but the IT/data side of the operation was missing. That's how this started.*

Complexity kept growing: new profile types were introduced (hence more dies - the tooling used to produce the profiles), more paint colors were used, more customers and orders came in, a growing stock of supplies and finished products needed to be ((controlled? managed?))...

So a feedback loop between building a data model and reshaping the log and Calc sheets started to take place.

It kept evolving, with rough edges and a long to-do list of pending ideas, built alongside the actual work of managing production, workers, providers, customers and other shareholders.

## License

MIT, see [LICENSE](./LICENSE).
