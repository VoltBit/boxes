create table experiment_result(
  experiment_id uuid NOT NULL,
  datapoint_id uuid NOT NULL,
  experiment_time timestamp NOT NULL,
  result_target int NOT NULL,
  primary key(experiment_id, datapoint_id)
);
