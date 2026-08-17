# Schema overview

## What starts a job

An extrusion or painting job always needs a production order behind it (`op_extrusion` /
`op_pintura`). That order doesn't have to come from a customer, though: plenty of production
existed just to keep stock topped up ahead of demand, with no customer order behind it at all.

When a production order does come from a customer, the link is a lookup table
(`op_extrusion_parapedido` / `op_pintura_parapedido`), not a direct reference on the order
itself, because one production order can cover more than one customer order at once, batching a
few requests for the same profile into a single run.

A customer order is really two tables: the intake (`generacion_pedidos`, who asked and when) and
the line items inside it (`pedidos`: profile, length, color, finish, quantity). What actually
shipped against each line is tracked separately (`pedidos_expedicion`), since an order can be
fulfilled gradually.

## Extrusion

```
op_extrusion → cortetochos → extrusion → envejecimiento
```

A production order states what to make and how much. Raw billet gets cut to length against it
(`cortetochos`), then pressed: `extrusion` is the run itself, and it's the hub everything else in
this chain hangs off, per-run detail and quality sampling included. Aging (`envejecimiento`, a
heat-treatment step) is the last thing that happens before the profile counts as finished stock.

Dies get tracked the way any piece of shop tooling would: one catalog entry per design
(`matrices`), but several physical copies of the same die can be in rotation, so wear and history
are tracked per physical die (`stock_matrices`). Each die has its own maintenance log:
`matrices_nitruracion` (nitriding cycles, a hardening treatment dies need periodically),
`matrices_mediciondureza` (hardness readings), `matrices_correccion` (repair notes). A die wears
out on its own schedule, independent of any single run, and which physical die a run used is its
own record (`op_extrusion_matriz` for what was planned, `extrusion_matriz` for what actually
happened). `nitruracion_kgmax` is the lookup table for how many kg a die can extrude before its
next nitriding, based on how many times it's already been nitrided and whether it's a fragile
die.

## Painting

```
op_pintura → pintura
```

A production order states what to paint, and `pintura` (the run itself) is checked against it
before loading: profile, length and color have to match, though this one's enforced at load time
rather than by the database itself. Paint stock (`pinturas`) comes from supplier deliveries
(`cargas_pinturas`/`cargas_pinturas_detalle`) and is tied to color codes (`colores`/
`colores_codigos`), since the same color can arrive from more than one supplier under a different
code each time.

## Reference data

Staff and customers (`rrhh`, `clientes`/`org_clientes`), raw material and paint supply, the
profile catalog (`perfiles`) and the die catalog above, a small finished-product catalog. None of
these are a stage of production, they just get referenced from wherever they're needed.
