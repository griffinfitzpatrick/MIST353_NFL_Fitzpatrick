# AI Coding Agent Instructions - NFL Database Project (Fitzpatrick)

## Project Overview
This is an **early-stage three-tier educational database project** for MIST353 that models NFL team data. The architecture consists of:
- **Data Layer**: SQL Server database (`MIST353_NFL_Fitzpatrick`) with normalized schema
- **API Layer**: Python-based data access (currently scaffolding)  
- **UI Layer**: Python-based testing/presentation (currently scaffolding)

## Critical Architecture & Patterns

### Database Design (Data/)
- **Primary convention**: File naming includes "Fitzpatrick" suffix (e.g., `CreateTablesFitzpatrick.sql`)
- **Execution order**: Files should be executed in sequence:
  1. `CreateTablesFitzpatrick.sql` - Table schema with CHECK/FK constraints
  2. `DatabaseProgrammingObjectsFitzpatrick.sql` - Stored procedures/functions (empty template)
  3. `InsertDataFitzpatrick.sql` - Sample data (empty template)
- **T-SQL specifics**: Uses IDENTITY for auto-generate IDs, CHECK constraints for domain restrictions (e.g., Conference IN 'AFC'/'NFC')
- **Current schema**: `ConferenceDivision` (parent) → `Team` (child via FK); schema is incomplete

### Known Issues to Fix
1. **FK Reference Error**: `FK_Team_ConferenceDivision` references `Conference` table (doesn't exist) - should reference `ConferenceDivision`
2. **Duplicate PK constraint**: Team table declares PRIMARY KEY twice
3. **Schema completeness**: Missing tables likely needed (Players, Games, Stats, etc.) - follow same naming patterns

### Python Layers (API/, UI/)
- Both `TestAPI.py` and `TestUI.py` are empty scaffolds
- **Expected pattern**: Use `import pyodbc` or `sqlalchemy` for DB connections
- No established API/UI patterns yet - establish conventions when implementing

## Development Workflow

### Adding Database Entities
1. Add table definitions to `CreateTablesFitzpatrick.sql` before the final `GO`
2. Update FK constraints to reference correct table names using `REFERENCES [TableName]`
3. Maintain CHECK constraints for domain modeling (e.g., position codes, status flags)
4. Test locally against `MIST353_NFL_Fitzpatrick` database

### Extending Code
- **API**: Will likely need connection abstraction and query methods
- **UI**: Consider pytest for testing; coordinate with API layer integration points
- **Naming**: Files, functions, tables should maintain "{Component}Fitzpatrick" naming where applicable

## Key Files Reference
- Schema definition: [Data/CreateTablesFitzpatrick.sql](Data/CreateTablesFitzpatrick.sql)
- Procedures template: [Data/DatabaseProgrammingObjectsFitzpatrick.sql](Data/DatabaseProgrammingObjectsFitzpatrick.sql)
- Data scripts: [Data/InsertDataFitzpatrick.sql](Data/InsertDataFitzpatrick.sql)
- API entry point: [API/TestAPI.py](API/TestAPI.py)
- UI entry point: [UI/TestUI.py](UI/TestUI.py)

## Important Notes
- This is a student project (educational context) - code quality standards may be flexible
- Database compatibility: SQL Server 2016+ (uses IDENTITY, standard T-SQL)
- No external dependencies documented yet (establish package requirements when creating API/UI)
