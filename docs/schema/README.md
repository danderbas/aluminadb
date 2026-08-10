# aluminadb — schema overview

A narrative walkthrough of how the schema fits together. For field-level reference, see
[tables.md](./tables.md) (table lists by group), [diagrams.md](./diagrams.md) (an ER-lite
diagram per group) and [erd.md](./erd.md) (full entity-relationship diagrams). This file is
about the database; for the physical manufacturing process it models, see
[../industrial_process.md](../industrial_process.md).

## Production runs against a production order, not directly against a customer order

Both processes, extrusion and painting, produce nothing until a production order exists:
`op_extrusion` for extrusion, `op_pintura` for painting ("op" = orden de producción,
production order). Every production step downstream references that order by its
`nro_op`/`nro_subop` pair:

- In extrusion, `cortetochos` (billet cutting) and `extrusion` (the press run) both carry
  `nro_op`/`nro_subop` as an enforced foreign key back to `op_extrusion`.
- In painting, `pintura` (the run itself) carries the same pair, but it's checked against the
  order at load time rather than enforced by the database as a foreign key (profile, length and
  color must match).

A production order can come from either of two places:

- **As a response to a customer order** (`pedidos`): a row exists in the junction table
  `op_extrusion_parapedido` / `op_pintura_parapedido`, linking the order back to one or more
  `pedidos` rows.
- **Proactively, to keep up a minimum stock**: the order exists on its own, with no row in the
  `*_parapedido` junction table, since there's no customer order driving it yet.

This is why the link between a customer order and its production order is a junction table rather
than a direct foreign key on `pedidos`: a single production order can, in principle, cover more
than one customer order, and plenty of production orders were never tied to a customer order at
all.

A customer order itself is two tables: `generacion_pedidos` (one row per intake — which customer,
who logged it, when) and `pedidos` (one row per line item — profile, length, color, finish,
quantity). `pedidos_expedicion` records what was actually delivered against it.

See the "Customer orders → production orders" diagram in [diagrams.md](./diagrams.md) for the
shape of this link.

## Extrusion: from order to aged profile

```
op_extrusion → cortetochos → extrusion → envejecimiento
```

`op_extrusion` states what to produce (profile, length, minimum quantity). `cortetochos` cuts
raw billet (`tocho0`) to length against it. `extrusion` is the press run itself; per-run detail
and QA sampling hang off it (`extrusion_corte`, `extrusion_entrada`, `extrusion_salida`,
`extrusion_muestraculote`, `extrusion_muestraperfil`, `extrusion_stats`). `envejecimiento`
(aging/hardening) is the last step before the profile is finished raw stock.

**Die logs.** `matrices` is the die catalog; `stock_matrices` is the set of physical die units
("series") behind each catalog entry, since one die code can have several physical copies in
rotation. Three log tables hang off `stock_matrices`:

- `matrices_nitruracion` — nitriding (hardening) cycles: when a die went out for nitriding and
  when it came back.
- `matrices_mediciondureza` — hardness readings taken on a die.
- `matrices_correccion` — repair/correction notes.

`nitruracion_kgmax` is a lookup table (max kg extrudable before the next nitriding is needed,
based on nitriding count and whether the die is fragile). Which physical die a given order used
or plans to use is recorded in `op_extrusion_matriz` (planned) and `extrusion_matriz` (actual,
per extrusion run).

## Painting: from order to coated profile

```
op_pintura → pintura
```

`op_pintura` states what to paint (profile, length, quantity, color). `pintura` is the run
itself — checked against the order at load time rather than FK-enforced, as noted above. Paint
stock (`pinturas`) is fed by deliveries (`cargas_pinturas`/`cargas_pinturas_detalle`) and tied to
`colores`/`colores_codigos` (color-to-supplier-code mapping).

## Reference data

Shared catalog/lookup tables referenced from multiple places, rather than a stage of either
production flow:

- **People & customers** — `rrhh` (staff), `clientes`/`org_clientes` (customers), `usuarios`
  (login accounts referenced by both).
- **Materials & supplies** — raw aluminum and paint intake and stock.
- **Profiles & dies** — the profile catalog (`perfiles`, referenced from customer orders, both
  production order types, and the product catalog) plus the die catalog and logs described above.
- **Product catalog** — finished-product groupings, mostly independent of the production flow.

## Where to go next

- [tables.md](./tables.md)
- [diagrams.md](./diagrams.md) — an ER-lite diagram per group.
- [erd.md](./erd.md) — full field-level entity-relationship diagrams
