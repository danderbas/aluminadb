# Views

30 views total

## Orders

| View | What it shows |
|---|---|
| `pedidos_v` | One row per order line item: product code (profile + finish + color + length), quantity, status, customer, priority — the main day-to-day order list. |
| `pedidos_expedicion_v` | Quantity actually delivered so far, per order line item. |
| `pedidos_pendientes_v` | Order line items still open (not yet fully delivered), with quantity remaining. |
| `pedidos_pendientes_resumen_v` | `pedidos_pendientes_v`, rolled up by product code and length — how much of each is still owed across all open orders. |

## Profile types and stock

| View | What it shows |
|---|---|
| `stock_perfiles_nat_resumen_v` | Natural-finish (unpainted), non-defective profile stock, summed across containers by profile code and length — the number painting planning actually needs. |
| `stock_perfiles_nat_resumen_conpesoydesc_v` | `stock_perfiles_nat_resumen_v` with computed weight (length × quantity × linear weight) and the profile's description added. |

## Billets & cutting

| View | What it shows |
|---|---|
| `cortetocho_pesoprom_v` | Average empirical billet weight per production order, from actual cutting records — used to turn a planned billet *count* into a planned *weight*. |

## Dies

| View | What it shows |
|---|---|
| `extrusion_matriz_kgextruidos_v` | Kg extruded per die (code + physical series), one row per extrusion run, flagged test vs. real. |
| `matrices_hojadevida_v` | A die's full "life sheet" — every event against it (extrusion runs, test runs, nitriding, correction, hardness readings) on one timeline. |
| `matrices_ultnit_v` | Each die's most recent nitriding cycle: dates and nitriding count so far. |
| `matrices_ultnitkg_v` | Kg extruded by each die since its last nitriding — the number nitriding scheduling is based on. |
| `matrices_nitruracion_v` | Nitriding status for every physical die in stock: count, kg since last nitriding. |
| `matrices_nitruracion_vv` | `matrices_nitruracion_v`, collapsed into one human-readable status string per die (available / in nitriding / never nitrided). |

## Extrusion orders

| View | What it shows |
|---|---|
| `ope_v` | One row per production order/suborder: profile, target length, billet-cut dimensions and count. |
| `plan_extrusion_sinpeso_v` | The extrusion production plan (planned date, order, billet count) before weight is added. |
| `plan_extrusion_v` | `plan_extrusion_sinpeso_v` with both empirical (from `cortetocho_pesoprom_v`) and theoretical billet weight added. |

## Extrusion production

| View | What it shows |
|---|---|
| `extrusion_kgentradatotal_v` | Total input weight (kg) per extrusion run, from billet entries. |
| `extrusion_pesolineal_v` | Average linear weight (kg/m) per extrusion run, from profile samples. |
| `extrusion_long_salida_v` | Total output length (m) per extrusion run. |
| `extrusion_kgsalidatotal_v` | Total output weight (kg) per extrusion run (linear weight × output length). |
| `extrusion_entradasalidatotal_v` | Input weight, output weight and yield (efficiency) per extrusion run. |
| `extrusion_entsaltot_v` | The above, joined back onto run details (date, order, profile). |
| `extrusion_entsaltotobj_v` | Target output weight (kg) per extrusion run, from the order's target length. |
| `extrusion_v` | The headline per-run view: actual yield vs. target yield, in one row per extrusion run. |
| `extrusion_pordia_v` | `extrusion_v` rolled up by day. |
| `extrusion_pormesano_v` | `extrusion_pordia_v` rolled up by month/year. |
| `extrusion_total_v` | Grand total across every month on record. |
| `extrusion_entsaltot_pordia_v` | `extrusion_entsaltot_v` (actual only, no target) rolled up by day. |
| `extrusion_entsaltot_pormesano_v` | `extrusion_entsaltot_pordia_v` rolled up by month/year. |

## Paint Materials and Supplies

| View | What it shows |
|---|---|
| `cajas_pinturas_v` | One row per paint box: supplier, color, batch dates, supplier's paint code. |
