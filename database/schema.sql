CREATE TABLE IF NOT EXISTS webhooks (
  webhook VARCHAR(255) NOT NULL,
  command VARCHAR(255) NOT NULL,
  secret VARCHAR(255) NOT NULL,
  PRIMARY KEY (webhook)
);

CREATE TABLE IF NOT EXISTS auth_groups (
    group_name VARCHAR(256) NOT NULL,
    PRIMARY KEY (group_name),
    description VARCHAR(256)
);

INSERT INTO auth_groups (group_name,description) VALUES ('super_admin','Has ability to read, write, and delete webhooks. Has ability to view, create, and delete tokens');
INSERT INTO auth_groups (group_name,description) VALUES ('admin','Has ability to read, write, and delete webhooks');
INSERT INTO auth_groups (group_name,description) VALUES ('execute', 'Has ability to only execute webhooks');

CREATE TABLE IF NOT EXISTS tokens (
    id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id),
    auth_group VARCHAR(256) NOT NULL,
    FOREIGN KEY (auth_group) REFERENCES auth_groups(group_name)
);

CREATE TABLE IF NOT EXISTS logs (
    id INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id),
    EVENT_ACTION varchar(256) not null,
    EVENT_TABLE varchar(256) not null,
    EVENT_VALUES varchar(256) not null
);



/*START webhook TRIGGERS ---------------------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE TRIGGER insert_webhook_trigger AFTER INSERT ON webhooks
FOR EACH ROW
BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('INSERT','webhooks',CONCAT('webhook:',NEW.webhook,',command:',NEW.command,',secret',NEW.secret))
END;

CREATE TRIGGER update_webhook_trigger AFTER UPDATE ON webhooks
FOR EACH ROW

BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('UPDATE','webhooks',CONCAT('webhook:',NEW.webhook,',command:',NEW.command,',secret',NEW.secret))
END;

CREATE TRIGGER delete_webhook_trigger AFTER DELETE ON webhooks
FOR EACH ROW
BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('DELETE','webhooks',CONCAT('webhook:',OLD.webhook,',command:',OLD.command,',secret',OLD.secret))
END;
/*END webhook TRIGGERS ---------------------------------------------------------------------------------------------------------------------------------------------------------*/



/*START auth_groups TRIGGERS ---------------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE TRIGGER insert_auth_groups AFTER INSERT ON auth_groups
FOR EACH ROW
BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('INSERT','auth_groups',CONCAT('group_name:',NEW.group_name,',description:',NEW.description))
END;

CREATE TRIGGER update_auth_groups_trigger AFTER UPDATE ON auth_groups
FOR EACH ROW

BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('UPDATE','auth_groups',CONCAT('group_name:',NEW.group_name,',description:',NEW.description))
END;

CREATE TRIGGER delete_auth_groups_trigger AFTER DELETE ON auth_groups
FOR EACH ROW
BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('DELETE','auth_groups',CONCAT('group_name:',OLD.group_name,',description:',OLD.description))
END;
/*END auth_groups TRIGGERS -----------------------------------------------------------------------------------------------------------------------------------------------------*/



/*START tokens TRIGGERS --------------------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE TRIGGER insert_tokens_trigger AFTER INSERT ON tokens
FOR EACH ROW
BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('INSERT','tokens',CONCAT('id:',NEW.id,',auth_group:',NEW.auth_group))
END;

CREATE TRIGGER update_tokens_trigger AFTER UPDATE ON tokens
FOR EACH ROW

BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('UPDATE','tokens',CONCAT('id:',NEW.id,',auth_group:',NEW.auth_group))
END;

CREATE TRIGGER delete_tokens_trigger AFTER DELETE ON tokens
FOR EACH ROW
BEGIN
    INSERT INTO logs (EVENT_ACTION,EVENT_TABLE,EVENT_VALUES) VALUES ('DELETE','tokens',CONCAT('id:',OLD.id,',auth_group:',OLD.auth_group))
END;
/*END tokens TRIGGERS ----------------------------------------------------------------------------------------------------------------------------------------------------------*/