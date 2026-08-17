# Capabilities

Things that one is able to do or know by querying the database.

## Production planning

- Decide what to extrude in a given day, in what sequence, with how many billets by weight (empirical or
  theoretical) (`plan_extrusion_v`)
- See which scheduled orders trace back to a real customer order vs. which are
  proactive stock-building (`op_extrusion_parapedido`)
- Roll up all still-unfulfilled demand by profile and length, across every open order, to
  prioritize the next batch (`pedidos_pendientes_resumen_v`)

## Die / tooling management

- Know which physical dies are over or approaching their nitriding limit,
  across the whole die inventory (`matrices_nitruracion_v`/`_vv`)
- Pull a single die's life history: every extrusion, test run, nitriding, correction,
  and hardness reading, on one timeline (`matrices_hojadevida_v`)
- Catch a wearing die before it becomes a quality problem, by tracking its output's drift from the
  profile's nominal linear weight over time (`infomatrizp`)
- Find every die capable of producing a given profile, before scheduling a run (`infoperfil`)

## Inventory / stock

- Know exactly how much of each raw (unpainted) profile is sitting in stock, by code and length,
  ready to plan painting or ship as-is (`stock_perfiles_nat_resumen_v`)
- Convert that stock into kilograms for a real weight-based inventory value
  (`stock_perfiles_nat_resumen_conpesoydesc_v`)
- Know which specific paint boxes are still on hand vs. already used, reconstructed entirely from
  movement history (`stock_pinturas`)

## Production reporting / yield

- Get actual-vs-target extrusion yield for any single run, and see whether the plant is running
  efficiently against its own targets (`extrusion_v`)
- Roll that up into daily, monthly, and all-time efficiency trends for a management-level view
  (`extrusion_pordia_v` → `extrusion_pormesano_v` → `extrusion_total_v`)
- Compute the same kind of yield ratio for painting that extrusion already tracks: kg of profile
  painted per kg of coating powder used. The schema supports it: `pintura` gives kg painted, paint
  box exits at a fixed 25 kg/box give kg consumed, and `perfiles.id_tipo` → `tipos_perfiles`
  encodes solid vs. tubular vs. semitubular, alongside `perimetro__mm`, for a real
  surface-area-based estimate. Never built as a real view. Doing it properly needs matching paint
  consumption to the profiles it was actually used on, by date and color, not a blunt total.

## Traceability / accountability

- Trace a single paint box back to its supplier, color, and batch dates (`cajas_pinturas_v`)
- Trace a finished, aged basket of profile all the way back through its production order and
  extrusion runs to the raw aluminum delivery its billets came from: supplier, receipt date, the
  mill's own production/heat number, and alloy (`envejecimiento_canastos_detalle` → `op_extrusion`
  → `extrusion`/`cortetochos` → `tocho0` → `cargas_aluminio_detalle`/`cargas_aluminio`). Not
  necessarily down to one exact billet or run, since one order can span a few of each, but
  narrowed to the specific order and delivery batch
- Trace that same finished basket back to which physical die (code and series) extruded it
  (`extrusion_matriz` → `stock_matrices`), tying finished-goods traceability into the same die
  history covered under Die management above
- Every action in the plant (cutting a billet, running an extrusion, nitriding a die, painting a
  run, logging an order) is tied to the specific worker who did it, so any of the above can also
  answer "who did this"

## Customer / order management

- One list of every open order with status, quantity, priority, and customer, refreshed live
  (`pedidos_v`)
- Know precisely what's shipped vs. still owed on any order (`pedidos_expedicion_v`/
  `pedidos_pendientes_v`)
- Reconstruct the full lifecycle of one customer order end to end: customer order → production
  order → specific run → delivery
