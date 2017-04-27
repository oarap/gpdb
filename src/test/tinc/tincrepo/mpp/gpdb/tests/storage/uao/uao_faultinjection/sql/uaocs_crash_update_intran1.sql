-- start_ignore
SET gp_create_table_random_default_distribution=off;
-- end_ignore
BEGIN;
-- start_ignore
-- In case of UPDATE, ORCA does not go through the ExecUpdate code path while
-- the purpose of this test is to PANIC in the appendonly_update code path.
-- Therefore, we turn off ORCA for this test.
SET optimizer=off;
-- end_ignore
UPDATE foo set b = 0 ;
COMMIT;
