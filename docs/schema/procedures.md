# aluminadb — procedures

Three stored procedures, all about dies, all meant to be called by hand (`CALL procedure(...)`)
rather than from anywhere else in the pipeline — nothing in `src/mysql/` or `src/bash/` calls any
of them.

| Procedure | What it does |
|---|---|
| `infomatrizp(cod_matriz, nro_serie_matriz)` | For one physical die: every extrusion run it was used in, with that run's average linear weight (kg/m) and its % deviation from the profile's nominal linear weight. A die drifting away from nominal weight is a wear signal, independent of nitriding status. |
| `infoperfil(cod_perfil)` | Given a profile code, every physical die that can produce it. A "which dies can make this?" lookup for production planning. |
| `infomatriz(cod_matriz, nro_serie_matriz, OUT nro_nitruraciones, OUT kg_dsdultnit)` | For one physical die: how many times it's been nitrided, how many kg it's extruded since its last nitriding, and (in the result set, alongside the `OUT` params) the kg limit and remaining headroom before it needs nitriding again. |

