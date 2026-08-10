# aluminadb — entity-relationship diagrams, by group

Same 65 working tables and 104 foreign-key relationships as [erd_all.md](./erd_all.md) /
[erd_all_grouped.md](./erd_all_grouped.md), split into one diagram per group instead of one
unified diagram — easier to read closely, at the cost of not showing the whole schema at once.
Groups and table lists match [tables.md](./tables.md) exactly, in the same order.

Cardinalities and relationship labels come from the same schema-verified data as
[erd_all.md](./erd_all.md) (columns, keys and nullability pulled from `information_schema`, not
hand-transcribed). A table pulled in only because another group's table references it (or is
referenced by it) shows up here as a stub with just its primary key — full detail on that table
lives in its own group's section.

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
