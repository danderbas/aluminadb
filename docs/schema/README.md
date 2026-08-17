# Schema overview

## What starts a job

An extrusion or painting job always needs a production order behind it (`op_extrusion` /
`op_pintura`). That order doesn't have to come from a customer, though: plenty of production
existed just to keep stock topped up ahead of demand, with no customer order behind it at all.

When a production order does come from a customer, the link is a lookup table
(`op_extrusion_parapedido` / `op_pintura_parapedido`), not a direct reference on the order
itself, because one production order can cover more than one customer order at once, batching a
few requests for the same profile into a single run.

A customer order is really two tables: the intake (who asked, when) and the line items inside it
(profile, length, color, finish, quantity). What actually shipped against each line is tracked
separately, since an order can be fulfilled gradually.

## Extrusion

Order, cut billet, press run, aged profile. A production order states what to make and how much.
Raw billet gets cut to length against it, then pressed: that's the run itself, with per-run detail
and quality sampling hanging off it. Aging (a heat-treatment step) is the last thing that happens
before the profile counts as finished stock.

Dies get tracked the way any piece of shop tooling would: one catalog entry per design
(`matrices`), but several physical copies of the same die can be in rotation, so wear and history
are tracked per physical die (`stock_matrices`). Each die has its own maintenance log: nitriding
cycles (a hardening treatment dies need periodically), hardness readings, and repair notes. A die
wears out on its own schedule, independent of any single run. There's a lookup table for how many
kg a die can extrude before its next nitriding, based on how many times it's already been
nitrided and whether it's a fragile die (`nitruracion_kgmax`).

## Painting

Order, then run. A production order states what to paint, and the run itself is checked against
it before loading: profile, length and color have to match, though this one's enforced at load
time rather than by the database itself. Paint stock comes from supplier deliveries and is tied
to color codes, since the same color can arrive from more than one supplier under a different
code each time.

## Reference data

Staff and customers, raw material and paint supply, the profile and die catalogs, a small
finished-product catalog. None of these are a stage of production, they just get referenced from
wherever they're needed.

## Where to go next

- [tables.md](./tables.md), [views.md](./views.md), [procedures.md](./procedures.md): every
  table, view and procedure, grouped by activity
- [erd_tables.md](./erd_tables.md), [erd_views.md](./erd_views.md): the same, as
  entity-relationship diagrams
- [../industrial_process.md](../industrial_process.md): the physical process behind all of this
