defmodule Greptime.V1.Analyzer do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :ENGLISH, 0
  field :CHINESE, 1
end

defmodule Greptime.V1.SkippingIndexType do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :BLOOM_FILTER, 0
end

defmodule Greptime.V1.AddColumnLocation.LocationType do
  @moduledoc false

  use Protobuf, enum: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :FIRST, 0
  field :AFTER, 1
end

defmodule Greptime.V1.DdlRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :expr, 0

  field :create_database, 1,
    type: Greptime.V1.CreateDatabaseExpr,
    json_name: "createDatabase",
    oneof: 0

  field :create_table, 2, type: Greptime.V1.CreateTableExpr, json_name: "createTable", oneof: 0
  field :alter_table, 3, type: Greptime.V1.AlterTableExpr, json_name: "alterTable", oneof: 0
  field :drop_table, 4, type: Greptime.V1.DropTableExpr, json_name: "dropTable", oneof: 0

  field :truncate_table, 7,
    type: Greptime.V1.TruncateTableExpr,
    json_name: "truncateTable",
    oneof: 0

  field :create_flow, 8, type: Greptime.V1.CreateFlowExpr, json_name: "createFlow", oneof: 0
  field :drop_flow, 9, type: Greptime.V1.DropFlowExpr, json_name: "dropFlow", oneof: 0
  field :create_view, 10, type: Greptime.V1.CreateViewExpr, json_name: "createView", oneof: 0
  field :drop_view, 11, type: Greptime.V1.DropViewExpr, json_name: "dropView", oneof: 0

  field :alter_database, 12,
    type: Greptime.V1.AlterDatabaseExpr,
    json_name: "alterDatabase",
    oneof: 0
end

defmodule Greptime.V1.CreateFlowExpr.FlowOptionsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Greptime.V1.CreateFlowExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :flow_name, 2, type: :string, json_name: "flowName"

  field :source_table_names, 3,
    repeated: true,
    type: Greptime.V1.TableName,
    json_name: "sourceTableNames"

  field :sink_table_name, 4, type: Greptime.V1.TableName, json_name: "sinkTableName"
  field :or_replace, 5, type: :bool, json_name: "orReplace"
  field :create_if_not_exists, 6, type: :bool, json_name: "createIfNotExists"
  field :expire_after, 7, type: Greptime.V1.ExpireAfter, json_name: "expireAfter"
  field :comment, 8, type: :string
  field :sql, 9, type: :string

  field :flow_options, 10,
    repeated: true,
    type: Greptime.V1.CreateFlowExpr.FlowOptionsEntry,
    json_name: "flowOptions",
    map: true
end

defmodule Greptime.V1.DropFlowExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :flow_name, 2, type: :string, json_name: "flowName"
  field :flow_id, 3, type: Greptime.V1.FlowId, json_name: "flowId"
  field :drop_if_exists, 5, type: :bool, json_name: "dropIfExists"
end

defmodule Greptime.V1.CreateViewExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :view_name, 3, type: :string, json_name: "viewName"
  field :logical_plan, 4, type: :bytes, json_name: "logicalPlan"
  field :create_if_not_exists, 5, type: :bool, json_name: "createIfNotExists"
  field :or_replace, 6, type: :bool, json_name: "orReplace"
  field :table_names, 7, repeated: true, type: Greptime.V1.TableName, json_name: "tableNames"
  field :columns, 8, repeated: true, type: :string
  field :plan_columns, 9, repeated: true, type: :string, json_name: "planColumns"
  field :definition, 10, type: :string
end

defmodule Greptime.V1.DropViewExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :view_name, 3, type: :string, json_name: "viewName"
  field :view_id, 4, type: Greptime.V1.TableId, json_name: "viewId"
  field :drop_if_exists, 5, type: :bool, json_name: "dropIfExists"
end

defmodule Greptime.V1.CreateTableExpr.TableOptionsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Greptime.V1.CreateTableExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :table_name, 3, type: :string, json_name: "tableName"
  field :desc, 4, type: :string
  field :column_defs, 5, repeated: true, type: Greptime.V1.ColumnDef, json_name: "columnDefs"
  field :time_index, 6, type: :string, json_name: "timeIndex"
  field :primary_keys, 7, repeated: true, type: :string, json_name: "primaryKeys"
  field :create_if_not_exists, 8, type: :bool, json_name: "createIfNotExists"

  field :table_options, 9,
    repeated: true,
    type: Greptime.V1.CreateTableExpr.TableOptionsEntry,
    json_name: "tableOptions",
    map: true

  field :table_id, 10, type: Greptime.V1.TableId, json_name: "tableId"
  field :engine, 12, type: :string
end

defmodule Greptime.V1.AlterTableExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :kind, 0

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :table_name, 3, type: :string, json_name: "tableName"
  field :add_columns, 4, type: Greptime.V1.AddColumns, json_name: "addColumns", oneof: 0
  field :drop_columns, 5, type: Greptime.V1.DropColumns, json_name: "dropColumns", oneof: 0
  field :rename_table, 6, type: Greptime.V1.RenameTable, json_name: "renameTable", oneof: 0

  field :modify_column_types, 7,
    type: Greptime.V1.ModifyColumnTypes,
    json_name: "modifyColumnTypes",
    oneof: 0

  field :set_table_options, 8,
    type: Greptime.V1.SetTableOptions,
    json_name: "setTableOptions",
    oneof: 0

  field :unset_table_options, 11,
    type: Greptime.V1.UnsetTableOptions,
    json_name: "unsetTableOptions",
    oneof: 0

  field :set_index, 12, type: Greptime.V1.SetIndex, json_name: "setIndex", oneof: 0
  field :unset_index, 13, type: Greptime.V1.UnsetIndex, json_name: "unsetIndex", oneof: 0
end

defmodule Greptime.V1.SetIndex do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :options, 0

  field :fulltext, 1, type: Greptime.V1.SetFulltext, oneof: 0
  field :inverted, 2, type: Greptime.V1.SetInverted, oneof: 0
  field :skipping, 3, type: Greptime.V1.SetSkipping, oneof: 0
end

defmodule Greptime.V1.UnsetIndex do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :options, 0

  field :fulltext, 1, type: Greptime.V1.UnsetFulltext, oneof: 0
  field :inverted, 2, type: Greptime.V1.UnsetInverted, oneof: 0
  field :skipping, 3, type: Greptime.V1.UnsetSkipping, oneof: 0
end

defmodule Greptime.V1.DropTableExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :table_name, 3, type: :string, json_name: "tableName"
  field :table_id, 4, type: Greptime.V1.TableId, json_name: "tableId"
  field :drop_if_exists, 5, type: :bool, json_name: "dropIfExists"
end

defmodule Greptime.V1.CreateDatabaseExpr.OptionsEntry do
  @moduledoc false

  use Protobuf, map: true, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Greptime.V1.CreateDatabaseExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :create_if_not_exists, 3, type: :bool, json_name: "createIfNotExists"
  field :options, 4, repeated: true, type: Greptime.V1.CreateDatabaseExpr.OptionsEntry, map: true
end

defmodule Greptime.V1.TruncateTableExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :table_name, 3, type: :string, json_name: "tableName"
  field :table_id, 4, type: Greptime.V1.TableId, json_name: "tableId"
end

defmodule Greptime.V1.DropDatabaseExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"
  field :drop_if_exists, 3, type: :bool, json_name: "dropIfExists"
end

defmodule Greptime.V1.AddColumns do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :add_columns, 1, repeated: true, type: Greptime.V1.AddColumn, json_name: "addColumns"
end

defmodule Greptime.V1.DropColumns do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :drop_columns, 1, repeated: true, type: Greptime.V1.DropColumn, json_name: "dropColumns"
end

defmodule Greptime.V1.ModifyColumnTypes do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :modify_column_types, 1,
    repeated: true,
    type: Greptime.V1.ModifyColumnType,
    json_name: "modifyColumnTypes"
end

defmodule Greptime.V1.RenameTable do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :new_table_name, 1, type: :string, json_name: "newTableName"
end

defmodule Greptime.V1.AddColumn do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_def, 1, type: Greptime.V1.ColumnDef, json_name: "columnDef"
  field :location, 3, type: Greptime.V1.AddColumnLocation
  field :add_if_not_exists, 4, type: :bool, json_name: "addIfNotExists"
end

defmodule Greptime.V1.ModifyColumnType do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :target_type, 2, type: Greptime.V1.ColumnDataType, json_name: "targetType", enum: true

  field :target_type_extension, 3,
    type: Greptime.V1.ColumnDataTypeExtension,
    json_name: "targetTypeExtension"
end

defmodule Greptime.V1.Option do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule Greptime.V1.SetTableOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :table_options, 1, repeated: true, type: Greptime.V1.Option, json_name: "tableOptions"
end

defmodule Greptime.V1.UnsetTableOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :keys, 1, repeated: true, type: :string
end

defmodule Greptime.V1.DropColumn do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :name, 1, type: :string
end

defmodule Greptime.V1.TableId do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :id, 1, type: :uint32
end

defmodule Greptime.V1.FlowId do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :id, 1, type: :uint32
end

defmodule Greptime.V1.ColumnDef do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :name, 1, type: :string
  field :data_type, 2, type: Greptime.V1.ColumnDataType, json_name: "dataType", enum: true
  field :is_nullable, 3, type: :bool, json_name: "isNullable"
  field :default_constraint, 4, type: :bytes, json_name: "defaultConstraint"
  field :semantic_type, 5, type: Greptime.V1.SemanticType, json_name: "semanticType", enum: true
  field :comment, 6, type: :string

  field :datatype_extension, 7,
    type: Greptime.V1.ColumnDataTypeExtension,
    json_name: "datatypeExtension"

  field :options, 8, type: Greptime.V1.ColumnOptions
end

defmodule Greptime.V1.AddColumnLocation do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :location_type, 1,
    type: Greptime.V1.AddColumnLocation.LocationType,
    json_name: "locationType",
    enum: true

  field :after_column_name, 2, type: :string, json_name: "afterColumnName"
end

defmodule Greptime.V1.SetFulltext do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :enable, 2, type: :bool
  field :analyzer, 3, type: Greptime.V1.Analyzer, enum: true
  field :case_sensitive, 4, type: :bool, json_name: "caseSensitive"
end

defmodule Greptime.V1.UnsetFulltext do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
end

defmodule Greptime.V1.SetInverted do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
end

defmodule Greptime.V1.UnsetInverted do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
end

defmodule Greptime.V1.SetSkipping do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
  field :enable, 2, type: :bool
  field :granularity, 3, type: :uint64

  field :skipping_index_type, 4,
    type: Greptime.V1.SkippingIndexType,
    json_name: "skippingIndexType",
    enum: true
end

defmodule Greptime.V1.UnsetSkipping do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :column_name, 1, type: :string, json_name: "columnName"
end

defmodule Greptime.V1.AlterDatabaseExpr do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  oneof :kind, 0

  field :catalog_name, 1, type: :string, json_name: "catalogName"
  field :schema_name, 2, type: :string, json_name: "schemaName"

  field :set_database_options, 3,
    type: Greptime.V1.SetDatabaseOptions,
    json_name: "setDatabaseOptions",
    oneof: 0

  field :unset_database_options, 4,
    type: Greptime.V1.UnsetDatabaseOptions,
    json_name: "unsetDatabaseOptions",
    oneof: 0
end

defmodule Greptime.V1.SetDatabaseOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :set_database_options, 1,
    repeated: true,
    type: Greptime.V1.Option,
    json_name: "setDatabaseOptions"
end

defmodule Greptime.V1.UnsetDatabaseOptions do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.14.0", syntax: :proto3

  field :keys, 1, repeated: true, type: :string
end
