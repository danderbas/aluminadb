# aluminadb

Data model + ETL pipeline for production management in an aluminum profile manufacturing plant.

## Watch it run

- [Quick start](./quickstart.html): setting up the schema and loading data, real unfiltered
  terminal output
- [Usage](./usage.html): the monthly report, shift planning with die availability, the nitriding
  due list

## Read about it

- [How it works](./how_it_works.md): spreadsheet to CSV to MySQL, the pipeline itself
- [What it can do](./capabilities.md): the real questions it could answer
- [The industrial process](./industrial_process.md): what extrusion and painting actually are

## Schema

[83 tables, 95 foreign keys, 31 views](./schema/erd.svg)

- [Overview](./schema/README.md): how the tables connect and why
- [Tables](./schema/tables.md), [Views](./schema/views.md), [Procedures](./schema/procedures.md):
  every entity, grouped by activity
- [Tables ERD](./schema/erd_tables.md), [Views ERD](./schema/erd_views.md): the same, as
  entity-relationship diagrams

## Source

[github.com/danderbas/aluminadb](https://github.com/danderbas/aluminadb), MIT licensed.
