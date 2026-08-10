# aluminadb — entity-relationship diagrams, by group

```mermaid
flowchart BT
  subgraph sg_People_workers_customers_["People (workers & customers)"]
    direction BT
    clientes["<b>clientes</b><br/>int id PK<br/>varchar usuario FK<br/>int id_organizacion FK<br/>varchar nombre<br/>varchar apellido<br/>varchar email<br/>int telefono"]
    org_clientes["<b>org_clientes</b><br/>int id PK<br/>varchar descripcion<br/>int telefono<br/>int telefono2<br/>varchar direccion<br/>varchar ubicacion"]
    rrhh["<b>rrhh</b><br/>int id PK<br/>int id_estado<br/>int nivel<br/>varchar usuario FK<br/>varchar nombre<br/>varchar apellido<br/>int ci<br/>date fecha_nacimiento<br/>varchar direccion<br/>varchar ubicacion<br/>varchar barrio<br/>varchar ciudad<br/>varchar nro_celular<br/>varchar nro_contactourgencia<br/>varchar relacion_contactourgencia<br/>int id_marcador"]
    usuarios["<b>usuarios</b><br/>varchar id PK<br/>varchar clave<br/>tinyint es_rrhh<br/>tinyint es_cliente<br/>tinyint es_delgrupo<br/>tinyint es_admin"]
  end
  subgraph sg_Orders["Orders"]
    direction BT
    estados_pedidos["<b>estados_pedidos</b><br/>int id PK<br/>varchar descripcion"]
    generacion_pedidos["<b>generacion_pedidos</b><br/>int nro_pedido PK<br/>int id_cliente FK<br/>int id_rrhh FK<br/>date fecha_recepcion<br/>time hora_recepcion<br/>varchar id_pedido_seguncliente<br/>varchar obra_uso<br/>text comentarios"]
    pedidos["<b>pedidos</b><br/>int nro_pedido PK,FK<br/>int nro_subpedido PK<br/>int id_tipo_pedido FK<br/>tinyint es_recibidoparapintar<br/>varchar codigo FK<br/>decimal long__m<br/>int id_tipo_acabado FK<br/>int id_color FK<br/>float cantidad<br/>int id_prioridad<br/>int id_estado FK"]
    pedidos_expedicion["<b>pedidos_expedicion</b><br/>int nro_pedido FK<br/>int nro_subpedido FK<br/>date fecha<br/>time hora<br/>int cant_perfiles"]
    tipos_acabado["<b>tipos_acabado</b><br/>int id PK<br/>char descripcion"]
    tipos_pedidos["<b>tipos_pedidos</b><br/>int id PK<br/>char descripcion<br/>varchar unidad"]
  end
  subgraph sg_Profile_types_and_stock["Profile types and stock"]
    direction BT
    perfiles["<b>perfiles</b><br/>varchar codigo PK<br/>varchar descripcion<br/>int id_tipo FK<br/>float pesolinealnominal__kg_m<br/>float perimetro__mm<br/>float area__mm2<br/>varchar codigo_externo<br/>tinyint es_extrusable"]
    tipos_perfiles["<b>tipos_perfiles</b><br/>int id PK<br/>char descripcion"]
    stock_contenedores_perfiles["<b>stock_contenedores_perfiles</b><br/>int id_tipo_contenedor PK,FK<br/>int id_contenedor PK"]
    tipos_contenedores_perfiles["<b>tipos_contenedores_perfiles</b><br/>int id PK<br/>char descripcion<br/>char abreviatura"]
    d_stock_perfiles["<b>d_stock_perfiles</b><br/>int id PK<br/>date fecha<br/>time hora<br/>int id_rrhh FK<br/>int id_tipo_contenedor_origen FK<br/>int id_contenedor_origen FK<br/>int id_tipo_contenedor_destino FK<br/>int id_contenedor_destino FK<br/>varchar cod_perfil FK<br/>decimal long_perfil__m<br/>tinyint es_envejecido<br/>int id_tipo_acabado FK<br/>int id_color FK<br/>tinyint es_defectuoso<br/>int cantidad<br/>int nro_extrusion FK<br/>int nro_envejecimiento FK<br/>int nro_pintura FK<br/>int id_impresion_etiq<br/>varchar comentario<br/>tinyint es_fix<br/>tinyint OK"]
    stock_perfiles["<b>stock_perfiles</b><br/>int id_tipo_contenedor PK,FK<br/>int id_contenedor PK,FK<br/>varchar cod_perfil PK,FK<br/>decimal long_perfil__m PK<br/>tinyint es_envejecido PK<br/>int id_tipo_acabado PK,FK<br/>int id_color PK,FK<br/>tinyint es_defectuoso PK<br/>int cantidad"]
  end
  subgraph sg_Extrusion_Materials["Extrusion Materials"]
    direction BT
    cargas_aluminio["<b>cargas_aluminio</b><br/>int nro_carga PK<br/>int id_proveedor_aluminio FK<br/>date fecha_recepcion"]
    cargas_aluminio_detalle["<b>cargas_aluminio_detalle</b><br/>int nro_carga PK,FK<br/>int nro_bulto PK<br/>varchar nro_produccion<br/>varchar aleacion<br/>int cant_tocho0<br/>decimal long_tocho0__cm<br/>float peso_neto__kg<br/>float peso_bruto__kg"]
    tocho0["<b>tocho0</b><br/>int nro PK<br/>int nro_carga FK<br/>int nro_bulto FK"]
  end
  subgraph sg_Billets_cutting["Billets & cutting"]
    direction BT
    cortetochos["<b>cortetochos</b><br/>int nro PK<br/>int nro_op FK<br/>int nro_subop FK<br/>date fecha<br/>time hora_inicio<br/>time hora_fin<br/>int id_rrhh FK<br/>int nro_tocho0 FK<br/>decimal long_inicial__cm<br/>decimal long_tocho__cm<br/>int cant_tochos<br/>float pesoprom_tochos__kg<br/>decimal long_final__cm<br/>float peso_resto__kg"]
  end
  subgraph sg_Dies["Dies"]
    direction BT
    matrices["<b>matrices</b><br/>varchar codigo PK<br/>int id_tipo FK<br/>varchar cod_perfil FK<br/>int nro_salidas<br/>int id_proveedor<br/>tinyint es_fragil"]
    matrices_correccion["<b>matrices_correccion</b><br/>int fecha<br/>int id_rrhh FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK<br/>text descripcion"]
    matrices_mediciondureza["<b>matrices_mediciondureza</b><br/>date fecha<br/>int id_rrhh FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK<br/>float dureza__rhc"]
    matrices_nitruracion["<b>matrices_nitruracion</b><br/>date fecha_salida<br/>date fecha_retorno<br/>int id_rrhh_salida FK<br/>int id_rrhh_retorno FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK"]
    nitruracion_kgmax["<b>nitruracion_kgmax</b><br/>int nro_nitruraciones PK<br/>tinyint es_fragil PK<br/>float max__kg PK"]
    stock_matrices["<b>stock_matrices</b><br/>varchar cod_matriz PK,FK<br/>int nro_serie PK<br/>varchar grabado"]
    tipos_matrices["<b>tipos_matrices</b><br/>int id PK<br/>char descripcion"]
  end
  subgraph sg_Extrusion_orders["Extrusion orders"]
    direction BT
    generacion_op_extrusion["<b>generacion_op_extrusion</b><br/>int nro_op PK<br/>date fecha<br/>int id_rrhh FK"]
    op_extrusion["<b>op_extrusion</b><br/>int nro_op PK,FK<br/>int nro_subop PK<br/>varchar cod_perfil FK<br/>decimal long_perfil__m<br/>int cant_perfil_min<br/>int id_estado"]
    op_extrusion_entrada["<b>op_extrusion_entrada</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>decimal long_tocho__cm PK<br/>int cant_tochos<br/>int cant_tochosporcorte<br/>float posicion_sierracorte<br/>int id_proveedor_aluminio FK"]
    op_extrusion_matriz["<b>op_extrusion_matriz</b><br/>int nro_op FK<br/>int nro_subop FK<br/>varchar cod_matriz FK<br/>int nro_serie_matriz FK"]
    op_extrusion_objetivo["<b>op_extrusion_objetivo</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>float long_mesa_objetivo__m<br/>int cant_perfil_objetivo<br/>float salida_objetivo__kg"]
    op_extrusion_parapedido["<b>op_extrusion_parapedido</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>int nro_pedido PK,FK<br/>int nro_subpedido PK,FK"]
    op_extrusion_planeamiento["<b>op_extrusion_planeamiento</b><br/>int nro_op FK<br/>int nro_subop FK<br/>float fraccion_entrada<br/>date fecha_planeada<br/>int orden"]
    s_op_extrusion_parapedido["<b>s_op_extrusion_parapedido</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>int nro_pedido PK,FK<br/>int nro_subpedido PK,FK<br/>tinyint OK"]
  end
  subgraph sg_Extrusion_production["Extrusion production"]
    direction BT
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
  end
  subgraph sg_Aging["Aging"]
    direction BT
    envejecimiento["<b>envejecimiento</b><br/>int nro PK<br/>date fecha_inicio<br/>time hora_inicio<br/>int id_rrhh_inicio FK<br/>date fecha_fin<br/>time hora_fin<br/>int id_rrhh_fin FK"]
    envejecimiento_canastos["<b>envejecimiento_canastos</b><br/>int nro_canasto<br/>int nro_envejecimiento FK<br/>int id_tipo_contenedor FK<br/>int id_contenedor FK"]
    envejecimiento_canastos_detalle["<b>envejecimiento_canastos_detalle</b><br/>int nro_canasto FK<br/>varchar cod_perfil FK<br/>decimal long_perfil__m<br/>int cantidad<br/>int nro_op FK<br/>int nro_subop FK"]
  end
  subgraph sg_Paint_Materials_and_Supplies["Paint Materials and Supplies"]
    direction BT
    cargas_pinturas["<b>cargas_pinturas</b><br/>int nro_carga PK<br/>int id_proveedor_pintura<br/>date fecha_recepcion<br/>int nro_remision<br/>int nro_factura<br/>text comentarios"]
    cargas_pinturas_detalle["<b>cargas_pinturas_detalle</b><br/>int nro_carga PK,FK<br/>int nro_subcarga PK<br/>varchar cod_pintura_proveedor FK<br/>varchar lote<br/>date fecha_elaboracion<br/>date fecha_vencimiento"]
    colores["<b>colores</b><br/>int id PK<br/>char abreviatura<br/>char descripcion"]
    colores_codigos["<b>colores_codigos</b><br/>varchar cod_pintura_proveedor PK<br/>varchar desc_proveedor<br/>int id_color FK<br/>int id_proveedor PK,FK<br/>int id_marca FK"]
    marcas["<b>marcas</b><br/>int id PK<br/>varchar descripcion"]
    pinturas["<b>pinturas</b><br/>int nro_caja PK<br/>int nro_carga FK<br/>int nro_subcarga FK"]
    proveedores["<b>proveedores</b><br/>int id PK<br/>varchar descripcion<br/>int id_tipo FK<br/>text otros_datos"]
    tipos_proveedores["<b>tipos_proveedores</b><br/>int id PK<br/>varchar descripcion"]
    d_stock_pinturas["<b>d_stock_pinturas</b><br/>int id PK<br/>date fecha<br/>time hora<br/>int id_rrhh FK<br/>int nro_caja FK<br/>int d_cantidad<br/>int nro_pedidointerno<br/>tinyint es_fix<br/>tinyint OK"]
    stock_pinturas["<b>stock_pinturas</b><br/>int nro_caja FK"]
  end
  subgraph sg_Painting_orders["Painting orders"]
    direction BT
    estados_op_pintura["<b>estados_op_pintura</b><br/>int id PK<br/>varchar descripcion"]
    generacion_op_pintura["<b>generacion_op_pintura</b><br/>int nro_op PK<br/>int id_color FK<br/>date fecha<br/>int id_rrhh FK"]
    op_pintura["<b>op_pintura</b><br/>int nro_op PK,FK<br/>int nro_subop PK<br/>varchar codigo FK<br/>decimal long__m<br/>int cantidad<br/>int id_estado FK"]
    op_pintura_parapedido["<b>op_pintura_parapedido</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>int nro_pedido PK,FK<br/>int nro_subpedido PK,FK"]
    op_pintura_planeamiento["<b>op_pintura_planeamiento</b><br/>int nro_op FK<br/>int nro_subop FK<br/>float fraccion_entrada<br/>date fecha_planeada<br/>int orden"]
    s_op_pintura_parapedido["<b>s_op_pintura_parapedido</b><br/>int nro_op PK,FK<br/>int nro_subop PK,FK<br/>int nro_pedido PK,FK<br/>int nro_subpedido PK,FK<br/>tinyint OK"]
  end
  subgraph sg_Painting_production["Painting production"]
    direction BT
    pintura["<b>pintura</b><br/>int nro PK<br/>int nro_op<br/>int nro_subop<br/>int id_color FK<br/>date fecha<br/>time hora_inicio<br/>time hora_fin<br/>int id_rrhh FK<br/>float velocidad_monovia<br/>int cant_porganchera<br/>varchar codigo<br/>float long__m<br/>int cantidad"]
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

  style sg_People_workers_customers_ fill:none,stroke:#c9a227,stroke-width:2px
  style sg_Orders fill:none,stroke:#4c7fa3,stroke-width:2px
  style sg_Profile_types_and_stock fill:none,stroke:#6a8f5c,stroke-width:2px
  style sg_Extrusion_Materials fill:none,stroke:#b05a6a,stroke-width:2px
  style sg_Billets_cutting fill:none,stroke:#8a5fb0,stroke-width:2px
  style sg_Dies fill:none,stroke:#b0795f,stroke-width:2px
  style sg_Extrusion_orders fill:none,stroke:#5fa0a0,stroke-width:2px
  style sg_Extrusion_production fill:none,stroke:#a05f8a,stroke-width:2px
  style sg_Aging fill:none,stroke:#8a9282,stroke-width:2px
  style sg_Paint_Materials_and_Supplies fill:none,stroke:#c9922a,stroke-width:2px
  style sg_Painting_orders fill:none,stroke:#5f7fb0,stroke-width:2px
  style sg_Painting_production fill:none,stroke:#b05f5f,stroke-width:2px
```


## People (workers & customers)

4 tables, 19 external references.

```mermaid
erDiagram
    clientes {
        int id PK
        varchar usuario FK
        int id_organizacion FK
        varchar nombre
        varchar apellido
        varchar email
        int telefono
    }
    org_clientes {
        int id PK
        varchar descripcion
        int telefono
        int telefono2
        varchar direccion
        varchar ubicacion
    }
    rrhh {
        int id PK
        int id_estado
        int nivel
        varchar usuario FK
        varchar nombre
        varchar apellido
        int ci
        date fecha_nacimiento
        varchar direccion
        varchar ubicacion
        varchar barrio
        varchar ciudad
        varchar nro_celular
        varchar nro_contactourgencia
        varchar relacion_contactourgencia
        int id_marcador
    }
    usuarios {
        varchar id PK
        varchar clave
        tinyint es_rrhh
        tinyint es_cliente
        tinyint es_delgrupo
        tinyint es_admin
    }
    cortetochos {
        int nro PK
    }
    d_stock_perfiles {
        int id PK
    }
    d_stock_pinturas {
        int id PK
    }
    envejecimiento {
        int nro PK
    }
    extrusion {
        int nro PK
    }
    extrusion_corte {
    }
    generacion_op_extrusion {
        int nro_op PK
    }
    generacion_op_pintura {
        int nro_op PK
    }
    generacion_pedidos {
        int nro_pedido PK
    }
    matrices_correccion {
    }
    matrices_mediciondureza {
    }
    matrices_nitruracion {
    }
    pintura {
        int nro PK
    }
    s_extrusion {
        int nro PK
    }

    usuarios |o--o{ clientes : "as user"
    org_clientes ||--o{ clientes : "belongs to org"
    usuarios |o--o{ rrhh : "as user"
    rrhh ||--o{ matrices_correccion : "recorded by"
    rrhh ||--o{ matrices_mediciondureza : "recorded by"
    rrhh ||--o{ matrices_nitruracion : "sent out by"
    rrhh ||--o{ matrices_nitruracion : "returned by"
    rrhh |o--o{ generacion_pedidos : "recorded by"
    clientes |o--o{ generacion_pedidos : "requested by"
    rrhh |o--o{ generacion_op_extrusion : "recorded by"
    rrhh |o--o{ generacion_op_pintura : "recorded by"
    rrhh |o--o{ cortetochos : "recorded by"
    rrhh |o--o{ extrusion : "recorded by"
    rrhh ||--o{ extrusion_corte : "cut by (operator 1)"
    rrhh ||--o{ extrusion_corte : "cut by (operator 2)"
    rrhh |o--o{ s_extrusion : "recorded by"
    rrhh ||--o{ envejecimiento : "started by"
    rrhh |o--o{ envejecimiento : "ended by"
    rrhh |o--o{ pintura : "recorded by"
    rrhh ||--o{ d_stock_perfiles : "recorded by"
    rrhh ||--o{ d_stock_pinturas : "recorded by"
```

## Orders

6 tables, 10 external references.

```mermaid
erDiagram
    estados_pedidos {
        int id PK
        varchar descripcion
    }
    generacion_pedidos {
        int nro_pedido PK
        int id_cliente FK
        int id_rrhh FK
        date fecha_recepcion
        time hora_recepcion
        varchar id_pedido_seguncliente
        varchar obra_uso
        text comentarios
    }
    pedidos {
        int nro_pedido PK,FK
        int nro_subpedido PK
        int id_tipo_pedido FK
        tinyint es_recibidoparapintar
        varchar codigo FK
        decimal long__m
        int id_tipo_acabado FK
        int id_color FK
        float cantidad
        int id_prioridad
        int id_estado FK
    }
    pedidos_expedicion {
        int nro_pedido FK
        int nro_subpedido FK
        date fecha
        time hora
        int cant_perfiles
    }
    tipos_acabado {
        int id PK
        char descripcion
    }
    tipos_pedidos {
        int id PK
        char descripcion
        varchar unidad
    }
    clientes {
        int id PK
    }
    colores {
        int id PK
    }
    d_stock_perfiles {
        int id PK
    }
    op_extrusion_parapedido {
        int nro_op PK
        int nro_subop PK
        int nro_pedido PK
        int nro_subpedido PK
    }
    op_pintura_parapedido {
        int nro_op PK
        int nro_subop PK
        int nro_pedido PK
        int nro_subpedido PK
    }
    perfiles {
        varchar codigo PK
    }
    rrhh {
        int id PK
    }
    s_op_extrusion_parapedido {
        int nro_op PK
        int nro_subop PK
        int nro_pedido PK
        int nro_subpedido PK
    }
    s_op_pintura_parapedido {
        int nro_op PK
        int nro_subop PK
        int nro_pedido PK
        int nro_subpedido PK
    }
    stock_perfiles {
        int id_tipo_contenedor PK
        int id_contenedor PK
        varchar cod_perfil PK
        decimal long_perfil__m PK
        tinyint es_envejecido PK
        int id_tipo_acabado PK
        int id_color PK
        tinyint es_defectuoso PK
    }

    rrhh |o--o{ generacion_pedidos : "recorded by"
    clientes |o--o{ generacion_pedidos : "requested by"
    generacion_pedidos ||--o{ pedidos : "for order"
    perfiles ||--o{ pedidos : "of profile"
    tipos_pedidos ||--o{ pedidos : "is type"
    tipos_acabado ||--o{ pedidos : "has finish"
    colores ||--o{ pedidos : "in color"
    estados_pedidos ||--o{ pedidos : "has status"
    pedidos ||--o{ pedidos_expedicion : "for order"
    pedidos ||--o{ op_extrusion_parapedido : "for order"
    pedidos ||--o{ s_op_extrusion_parapedido : "for order"
    pedidos ||--o{ op_pintura_parapedido : "for order"
    pedidos ||--o{ s_op_pintura_parapedido : "for order"
    tipos_acabado ||--o{ d_stock_perfiles : "has finish"
    tipos_acabado ||--o{ stock_perfiles : "has finish"
```

## Profile types and stock

6 tables, 17 external references.

```mermaid
erDiagram
    perfiles {
        varchar codigo PK
        varchar descripcion
        int id_tipo FK
        float pesolinealnominal__kg_m
        float perimetro__mm
        float area__mm2
        varchar codigo_externo
        tinyint es_extrusable
    }
    tipos_perfiles {
        int id PK
        char descripcion
    }
    stock_contenedores_perfiles {
        int id_tipo_contenedor PK,FK
        int id_contenedor PK
    }
    tipos_contenedores_perfiles {
        int id PK
        char descripcion
        char abreviatura
    }
    d_stock_perfiles {
        int id PK
        date fecha
        time hora
        int id_rrhh FK
        int id_tipo_contenedor_origen FK
        int id_contenedor_origen FK
        int id_tipo_contenedor_destino FK
        int id_contenedor_destino FK
        varchar cod_perfil FK
        decimal long_perfil__m
        tinyint es_envejecido
        int id_tipo_acabado FK
        int id_color FK
        tinyint es_defectuoso
        int cantidad
        int nro_extrusion FK
        int nro_envejecimiento FK
        int nro_pintura FK
        int id_impresion_etiq
        varchar comentario
        tinyint es_fix
        tinyint OK
    }
    stock_perfiles {
        int id_tipo_contenedor PK,FK
        int id_contenedor PK,FK
        varchar cod_perfil PK,FK
        decimal long_perfil__m PK
        tinyint es_envejecido PK
        int id_tipo_acabado PK,FK
        int id_color PK,FK
        tinyint es_defectuoso PK
        int cantidad
    }
    colores {
        int id PK
    }
    envejecimiento {
        int nro PK
    }
    envejecimiento_canastos {
    }
    envejecimiento_canastos_detalle {
    }
    extrusion {
        int nro PK
    }
    extrusion_salida {
    }
    matrices {
        varchar codigo PK
    }
    op_extrusion {
        int nro_op PK
        int nro_subop PK
    }
    op_pintura {
        int nro_op PK
        int nro_subop PK
    }
    pedidos {
        int nro_pedido PK
        int nro_subpedido PK
    }
    pintura {
        int nro PK
    }
    rrhh {
        int id PK
    }
    s_extrusion {
        int nro PK
    }
    tipos_acabado {
        int id PK
    }

    tipos_contenedores_perfiles ||--o{ stock_contenedores_perfiles : "in container type"
    perfiles ||--o{ matrices : "of profile"
    tipos_perfiles ||--o{ perfiles : "is type"
    perfiles ||--o{ pedidos : "of profile"
    perfiles ||--o{ op_extrusion : "of profile"
    perfiles |o--o{ op_pintura : "of profile"
    perfiles ||--o{ extrusion : "of profile"
    stock_contenedores_perfiles ||--o{ extrusion_salida : "in container type"
    perfiles ||--o{ s_extrusion : "of profile"
    stock_contenedores_perfiles ||--o{ envejecimiento_canastos : "in container type"
    rrhh ||--o{ d_stock_perfiles : "recorded by"
    stock_contenedores_perfiles |o--o{ d_stock_perfiles : "from container"
    stock_contenedores_perfiles |o--o{ d_stock_perfiles : "to container"
    perfiles ||--o{ d_stock_perfiles : "of profile"
    tipos_acabado ||--o{ d_stock_perfiles : "has finish"
    colores ||--o{ d_stock_perfiles : "in color"
    extrusion |o--o{ d_stock_perfiles : "from extrusion"
    envejecimiento |o--o{ d_stock_perfiles : "from aging batch"
    pintura |o--o{ d_stock_perfiles : "from painting run"
    stock_contenedores_perfiles ||--o{ stock_perfiles : "in container"
    perfiles ||--o{ stock_perfiles : "of profile"
    tipos_acabado ||--o{ stock_perfiles : "has finish"
    colores ||--o{ stock_perfiles : "in color"
    perfiles ||--o{ envejecimiento_canastos_detalle : "of profile"
```

## Extrusion Materials

3 tables, 2 external references.

```mermaid
erDiagram
    cargas_aluminio {
        int nro_carga PK
        int id_proveedor_aluminio FK
        date fecha_recepcion
    }
    cargas_aluminio_detalle {
        int nro_carga PK,FK
        int nro_bulto PK
        varchar nro_produccion
        varchar aleacion
        int cant_tocho0
        decimal long_tocho0__cm
        float peso_neto__kg
        float peso_bruto__kg
    }
    tocho0 {
        int nro PK
        int nro_carga FK
        int nro_bulto FK
    }
    cortetochos {
        int nro PK
    }
    proveedores {
        int id PK
    }

    proveedores ||--o{ cargas_aluminio : "supplied by"
    cargas_aluminio ||--o{ cargas_aluminio_detalle : "from load"
    cargas_aluminio_detalle |o--o{ tocho0 : "from load"
    tocho0 |o--o{ cortetochos : "of billet"
```

## Billets & cutting

1 table, 3 external references.

```mermaid
erDiagram
    cortetochos {
        int nro PK
        int nro_op FK
        int nro_subop FK
        date fecha
        time hora_inicio
        time hora_fin
        int id_rrhh FK
        int nro_tocho0 FK
        decimal long_inicial__cm
        decimal long_tocho__cm
        int cant_tochos
        float pesoprom_tochos__kg
        decimal long_final__cm
        float peso_resto__kg
    }
    op_extrusion {
        int nro_op PK
        int nro_subop PK
    }
    rrhh {
        int id PK
    }
    tocho0 {
        int nro PK
    }

    tocho0 |o--o{ cortetochos : "of billet"
    op_extrusion |o--o{ cortetochos : "for op"
    rrhh |o--o{ cortetochos : "recorded by"
```

## Dies

7 tables, 9 external references.

```mermaid
erDiagram
    matrices {
        varchar codigo PK
        int id_tipo FK
        varchar cod_perfil FK
        int nro_salidas
        int id_proveedor
        tinyint es_fragil
    }
    matrices_correccion {
        int fecha
        int id_rrhh FK
        varchar cod_matriz FK
        int nro_serie_matriz FK
        text descripcion
    }
    matrices_mediciondureza {
        date fecha
        int id_rrhh FK
        varchar cod_matriz FK
        int nro_serie_matriz FK
        float dureza__rhc
    }
    matrices_nitruracion {
        date fecha_salida
        date fecha_retorno
        int id_rrhh_salida FK
        int id_rrhh_retorno FK
        varchar cod_matriz FK
        int nro_serie_matriz FK
    }
    nitruracion_kgmax {
        int nro_nitruraciones PK
        tinyint es_fragil PK
        float max__kg PK
    }
    stock_matrices {
        varchar cod_matriz PK,FK
        int nro_serie PK
        varchar grabado
    }
    tipos_matrices {
        int id PK
        char descripcion
    }
    extrusion_matriz {
        int nro_extrusion PK
    }
    op_extrusion_matriz {
    }
    perfiles {
        varchar codigo PK
    }
    rrhh {
        int id PK
    }
    s_extrusion_matriz {
        int nro_extrusion PK
    }

    tipos_matrices ||--o{ matrices : "is type"
    perfiles ||--o{ matrices : "of profile"
    stock_matrices ||--o{ matrices_correccion : "using die"
    rrhh ||--o{ matrices_correccion : "recorded by"
    stock_matrices ||--o{ matrices_mediciondureza : "using die"
    rrhh ||--o{ matrices_mediciondureza : "recorded by"
    stock_matrices ||--o{ matrices_nitruracion : "using die"
    rrhh ||--o{ matrices_nitruracion : "sent out by"
    rrhh ||--o{ matrices_nitruracion : "returned by"
    matrices ||--o{ stock_matrices : "using die"
    stock_matrices |o--o{ op_extrusion_matriz : "using die"
    stock_matrices ||--o{ extrusion_matriz : "using die"
    stock_matrices ||--o{ s_extrusion_matriz : "using die"
```

## Extrusion orders

9 tables, 11 external references.

```mermaid
erDiagram
    generacion_op_extrusion {
        int nro_op PK
        date fecha
        int id_rrhh FK
    }
    op_extrusion {
        int nro_op PK,FK
        int nro_subop PK
        varchar cod_perfil FK
        decimal long_perfil__m
        int cant_perfil_min
        int id_estado
    }
    op_extrusion_entrada {
        int nro_op PK,FK
        int nro_subop PK,FK
        decimal long_tocho__cm PK
        int cant_tochos
        int cant_tochosporcorte
        float posicion_sierracorte
        int id_proveedor_aluminio FK
    }
    op_extrusion_matriz {
        int nro_op FK
        int nro_subop FK
        varchar cod_matriz FK
        int nro_serie_matriz FK
    }
    op_extrusion_objetivo {
        int nro_op PK,FK
        int nro_subop PK,FK
        float long_mesa_objetivo__m
        int cant_perfil_objetivo
        float salida_objetivo__kg
    }
    op_extrusion_parapedido {
        int nro_op PK,FK
        int nro_subop PK,FK
        int nro_pedido PK,FK
        int nro_subpedido PK,FK
    }
    op_extrusion_planeamiento {
        int nro_op FK
        int nro_subop FK
        float fraccion_entrada
        date fecha_planeada
        int orden
    }
    s_op_extrusion_parapedido {
        int nro_op PK,FK
        int nro_subop PK,FK
        int nro_pedido PK,FK
        int nro_subpedido PK,FK
        tinyint OK
    }
    cortetochos {
        int nro PK
    }
    envejecimiento_canastos_detalle {
    }
    extrusion {
        int nro PK
    }
    pedidos {
        int nro_pedido PK
        int nro_subpedido PK
    }
    perfiles {
        varchar codigo PK
    }
    proveedores {
        int id PK
    }
    rrhh {
        int id PK
    }
    s_extrusion {
        int nro PK
    }
    stock_matrices {
        varchar cod_matriz PK
        int nro_serie PK
    }

    rrhh |o--o{ generacion_op_extrusion : "recorded by"
    generacion_op_extrusion ||--o{ op_extrusion : "for op"
    perfiles ||--o{ op_extrusion : "of profile"
    op_extrusion ||--o{ op_extrusion_entrada : "for op"
    proveedores |o--o{ op_extrusion_entrada : "supplied by"
    op_extrusion ||--o{ op_extrusion_matriz : "for op"
    stock_matrices |o--o{ op_extrusion_matriz : "using die"
    op_extrusion ||--o{ op_extrusion_objetivo : "for op"
    op_extrusion ||--o{ op_extrusion_parapedido : "for op"
    pedidos ||--o{ op_extrusion_parapedido : "for order"
    op_extrusion ||--o{ op_extrusion_planeamiento : "for op"
    op_extrusion ||--o{ s_op_extrusion_parapedido : "for op"
    pedidos ||--o{ s_op_extrusion_parapedido : "for order"
    op_extrusion |o--o{ cortetochos : "for op"
    op_extrusion |o--o{ extrusion : "for op"
    op_extrusion |o--o{ s_extrusion : "for op"
    op_extrusion |o--o{ envejecimiento_canastos_detalle : "for op"
```

## Extrusion production

10 tables, 12 external references.

```mermaid
erDiagram
    extrusion {
        int nro PK
        date fecha
        time hora_inicio
        time hora_fin
        int id_rrhh FK
        int nro_op FK
        int nro_subop FK
        varchar cod_perfil FK
    }
    extrusion_corte {
        int nro_extrusion FK
        date fecha
        time hora_inicio
        time hora_fin
        int id_rrhh_1 FK
        int id_rrhh_2 FK
    }
    extrusion_entrada {
        int nro_extrusion PK,FK
        decimal long_tocho__cm PK
        float peso_unit__kg
        int cantidad
    }
    extrusion_matriz {
        int nro_extrusion PK,FK
        varchar cod_matriz FK
        int nro_serie_matriz FK
    }
    extrusion_muestraculote {
        int nro_extrusion FK
        int cant_culote
        float peso_total__kg
    }
    extrusion_muestraperfil {
        int nro_extrusion FK
        int nro_salida
        decimal long_muestraperfil__cm
        float peso_muestra__g
    }
    extrusion_salida {
        int nro_extrusion FK
        decimal long_perfil__m
        int cantidad
        int id_tipo_contenedor FK
        int id_contenedor FK
    }
    extrusion_stats {
        int nro_extrusion PK,FK
        tinyint es_prueba
        float pos_sierracorte
        float long_mesa__m
        float temp_tocho_entrada__c
        float temp_perfil_salida__c
        tinyint sugiere_correccion_matriz
        tinyint extrusion_detenida
        text comentarios
    }
    s_extrusion {
        int nro PK
        date fecha
        time hora_inicio
        time hora_fin
        int id_rrhh FK
        int nro_op FK
        int nro_subop FK
        varchar cod_perfil FK
        tinyint OK
    }
    s_extrusion_matriz {
        int nro_extrusion PK,FK
        varchar cod_matriz FK
        int nro_serie_matriz FK
        tinyint OK
    }
    d_stock_perfiles {
        int id PK
    }
    op_extrusion {
        int nro_op PK
        int nro_subop PK
    }
    perfiles {
        varchar codigo PK
    }
    rrhh {
        int id PK
    }
    stock_contenedores_perfiles {
        int id_tipo_contenedor PK
        int id_contenedor PK
    }
    stock_matrices {
        varchar cod_matriz PK
        int nro_serie PK
    }

    perfiles ||--o{ extrusion : "of profile"
    op_extrusion |o--o{ extrusion : "for op"
    rrhh |o--o{ extrusion : "recorded by"
    extrusion ||--o{ extrusion_corte : "from extrusion"
    rrhh ||--o{ extrusion_corte : "cut by (operator 1)"
    rrhh ||--o{ extrusion_corte : "cut by (operator 2)"
    extrusion ||--o{ extrusion_entrada : "from extrusion"
    extrusion ||--o{ extrusion_matriz : "from extrusion"
    stock_matrices ||--o{ extrusion_matriz : "using die"
    extrusion ||--o{ extrusion_muestraculote : "from extrusion"
    extrusion ||--o{ extrusion_muestraperfil : "from extrusion"
    extrusion ||--o{ extrusion_salida : "from extrusion"
    stock_contenedores_perfiles ||--o{ extrusion_salida : "in container type"
    extrusion ||--o{ extrusion_stats : "from extrusion"
    perfiles ||--o{ s_extrusion : "of profile"
    op_extrusion |o--o{ s_extrusion : "for op"
    rrhh |o--o{ s_extrusion : "recorded by"
    extrusion ||--o{ s_extrusion_matriz : "from extrusion"
    stock_matrices ||--o{ s_extrusion_matriz : "using die"
    extrusion |o--o{ d_stock_perfiles : "from extrusion"
```

## Aging

3 tables, 6 external references.

```mermaid
erDiagram
    envejecimiento {
        int nro PK
        date fecha_inicio
        time hora_inicio
        int id_rrhh_inicio FK
        date fecha_fin
        time hora_fin
        int id_rrhh_fin FK
    }
    envejecimiento_canastos {
        int nro_canasto
        int nro_envejecimiento FK
        int id_tipo_contenedor FK
        int id_contenedor FK
    }
    envejecimiento_canastos_detalle {
        int nro_canasto FK
        varchar cod_perfil FK
        decimal long_perfil__m
        int cantidad
        int nro_op FK
        int nro_subop FK
    }
    d_stock_perfiles {
        int id PK
    }
    op_extrusion {
        int nro_op PK
        int nro_subop PK
    }
    perfiles {
        varchar codigo PK
    }
    rrhh {
        int id PK
    }
    stock_contenedores_perfiles {
        int id_tipo_contenedor PK
        int id_contenedor PK
    }

    rrhh ||--o{ envejecimiento : "started by"
    rrhh |o--o{ envejecimiento : "ended by"
    envejecimiento ||--o{ envejecimiento_canastos : "from aging batch"
    stock_contenedores_perfiles ||--o{ envejecimiento_canastos : "in container type"
    envejecimiento |o--o{ d_stock_perfiles : "from aging batch"
    envejecimiento_canastos ||--o{ envejecimiento_canastos_detalle : "in basket"
    perfiles ||--o{ envejecimiento_canastos_detalle : "of profile"
    op_extrusion |o--o{ envejecimiento_canastos_detalle : "for op"
```

## Paint Materials and Supplies

10 tables, 9 external references.

```mermaid
erDiagram
    cargas_pinturas {
        int nro_carga PK
        int id_proveedor_pintura
        date fecha_recepcion
        int nro_remision
        int nro_factura
        text comentarios
    }
    cargas_pinturas_detalle {
        int nro_carga PK,FK
        int nro_subcarga PK
        varchar cod_pintura_proveedor FK
        varchar lote
        date fecha_elaboracion
        date fecha_vencimiento
    }
    colores {
        int id PK
        char abreviatura
        char descripcion
    }
    colores_codigos {
        varchar cod_pintura_proveedor PK
        varchar desc_proveedor
        int id_color FK
        int id_proveedor PK,FK
        int id_marca FK
    }
    marcas {
        int id PK
        varchar descripcion
    }
    pinturas {
        int nro_caja PK
        int nro_carga FK
        int nro_subcarga FK
    }
    proveedores {
        int id PK
        varchar descripcion
        int id_tipo FK
        text otros_datos
    }
    tipos_proveedores {
        int id PK
        varchar descripcion
    }
    d_stock_pinturas {
        int id PK
        date fecha
        time hora
        int id_rrhh FK
        int nro_caja FK
        int d_cantidad
        int nro_pedidointerno
        tinyint es_fix
        tinyint OK
    }
    stock_pinturas {
        int nro_caja FK
    }
    cargas_aluminio {
        int nro_carga PK
    }
    d_stock_perfiles {
        int id PK
    }
    generacion_op_pintura {
        int nro_op PK
    }
    op_extrusion_entrada {
        int nro_op PK
        int nro_subop PK
        decimal long_tocho__cm PK
    }
    pedidos {
        int nro_pedido PK
        int nro_subpedido PK
    }
    pintura {
        int nro PK
    }
    rrhh {
        int id PK
    }
    stock_perfiles {
        int id_tipo_contenedor PK
        int id_contenedor PK
        varchar cod_perfil PK
        decimal long_perfil__m PK
        tinyint es_envejecido PK
        int id_tipo_acabado PK
        int id_color PK
        tinyint es_defectuoso PK
    }

    proveedores ||--o{ cargas_aluminio : "supplied by"
    cargas_pinturas ||--o{ cargas_pinturas_detalle : "from load"
    colores_codigos ||--o{ cargas_pinturas_detalle : "of paint code"
    colores ||--o{ colores_codigos : "in color"
    proveedores ||--o{ colores_codigos : "supplied by"
    marcas |o--o{ colores_codigos : "of brand"
    cargas_pinturas_detalle |o--o{ pinturas : "from load"
    tipos_proveedores |o--o{ proveedores : "is type"
    colores ||--o{ pedidos : "in color"
    proveedores |o--o{ op_extrusion_entrada : "supplied by"
    colores ||--o{ generacion_op_pintura : "in color"
    colores ||--o{ pintura : "in color"
    colores ||--o{ d_stock_perfiles : "in color"
    colores ||--o{ stock_perfiles : "in color"
    rrhh ||--o{ d_stock_pinturas : "recorded by"
    pinturas ||--o{ d_stock_pinturas : "of box"
    pinturas ||--o{ stock_pinturas : "of box"
```

## Painting orders

6 tables, 5 external references.

```mermaid
erDiagram
    estados_op_pintura {
        int id PK
        varchar descripcion
    }
    generacion_op_pintura {
        int nro_op PK
        int id_color FK
        date fecha
        int id_rrhh FK
    }
    op_pintura {
        int nro_op PK,FK
        int nro_subop PK
        varchar codigo FK
        decimal long__m
        int cantidad
        int id_estado FK
    }
    op_pintura_parapedido {
        int nro_op PK,FK
        int nro_subop PK,FK
        int nro_pedido PK,FK
        int nro_subpedido PK,FK
    }
    op_pintura_planeamiento {
        int nro_op FK
        int nro_subop FK
        float fraccion_entrada
        date fecha_planeada
        int orden
    }
    s_op_pintura_parapedido {
        int nro_op PK,FK
        int nro_subop PK,FK
        int nro_pedido PK,FK
        int nro_subpedido PK,FK
        tinyint OK
    }
    colores {
        int id PK
    }
    pedidos {
        int nro_pedido PK
        int nro_subpedido PK
    }
    perfiles {
        varchar codigo PK
    }
    rrhh {
        int id PK
    }

    colores ||--o{ generacion_op_pintura : "in color"
    rrhh |o--o{ generacion_op_pintura : "recorded by"
    generacion_op_pintura ||--o{ op_pintura : "for op"
    perfiles |o--o{ op_pintura : "of profile"
    estados_op_pintura ||--o{ op_pintura : "has status"
    op_pintura ||--o{ op_pintura_parapedido : "for op"
    pedidos ||--o{ op_pintura_parapedido : "for order"
    op_pintura ||--o{ op_pintura_planeamiento : "for op"
    op_pintura ||--o{ s_op_pintura_parapedido : "for op"
    pedidos ||--o{ s_op_pintura_parapedido : "for order"
```

## Painting production

2 tables, 5 external references.

```mermaid
erDiagram
    pintura {
        int nro PK
        int nro_op
        int nro_subop
        int id_color FK
        date fecha
        time hora_inicio
        time hora_fin
        int id_rrhh FK
        float velocidad_monovia
        int cant_porganchera
        varchar codigo
        float long__m
        int cantidad
    }
    colores {
        int id PK
    }
    d_stock_perfiles {
        int id PK
    }
    rrhh {
        int id PK
    }

    colores ||--o{ pintura : "in color"
    rrhh |o--o{ pintura : "recorded by"
    pintura |o--o{ d_stock_perfiles : "from painting run"
```
