-- Use logging
select console.log('Start process');
select console.info('load data...');
select console.warn('this could be slow');
select console.error('error at loading data');

-- View Logs
select * from console_log order by created_at;
