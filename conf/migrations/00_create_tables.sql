-- users

CREATE TYPE user_authentication_type AS ENUM ('Email', 'Provider');
CREATE TYPE user_role AS ENUM ('Admin', 'User');

CREATE TABLE users (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    authentication_type user_authentication_type NOT NULL,
    role user_role NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER update_users_updated_at_step1 BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_none();
CREATE TRIGGER update_users_updated_at_step2 BEFORE UPDATE OF updated_at ON users FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_same();
CREATE TRIGGER update_users_updated_at_step3 BEFORE UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_current();

-- user_auth_emails

CREATE TABLE user_auth_emails (
    email VARCHAR(255) NOT NULL PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    salt VARCHAR(255) NOT NULL,
    email_verified BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TRIGGER update_user_auth_emails_updated_at_step1 BEFORE UPDATE ON user_auth_emails FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_none();
CREATE TRIGGER update_user_auth_emails_updated_at_step2 BEFORE UPDATE OF updated_at ON user_auth_emails FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_same();
CREATE TRIGGER update_user_auth_emails_updated_at_step3 BEFORE UPDATE ON user_auth_emails FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_current();

-- user_auth_providers

CREATE TABLE user_auth_providers (
    provider_type VARCHAR(255) NOT NULL,
    provider_user_id VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(provider_type, provider_user_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE UNIQUE INDEX user_auth_providers_provider_type_provider_user_id_unique_index ON user_auth_providers(provider_type, provider_user_id);

-- refresh_tokens

CREATE TABLE refresh_tokens (
    refresh_token VARCHAR(255) NOT NULL PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    ip_address VARCHAR(255) NOT NULL,
    user_agent VARCHAR(1024) NOT NULL,
    expires_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
CREATE TRIGGER update_refresh_tokens_updated_at_step1 BEFORE UPDATE ON refresh_tokens FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_none();
CREATE TRIGGER update_refresh_tokens_updated_at_step2 BEFORE UPDATE OF updated_at ON refresh_tokens FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_same();
CREATE TRIGGER update_refresh_tokens_updated_at_step3 BEFORE UPDATE ON refresh_tokens FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_current();

-- email_send_jobs

CREATE TABLE email_send_jobs (
    job_id VARCHAR(255) NOT NULL PRIMARY KEY,
    batch_count INTEGER NOT NULL,
    email_address_count INTEGER NOT NULL,
    type VARCHAR(32) NOT NULL,
    param TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- email_send_job_batches

CREATE TABLE email_send_job_batches (
    job_id VARCHAR(255) NOT NULL,
    batch_id INTEGER NOT NULL,
    status VARCHAR(32) NOT NULL,
    PRIMARY KEY(job_id, batch_id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER update_email_send_job_batches_updated_at_step1 BEFORE UPDATE ON email_send_job_batches FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_none();
CREATE TRIGGER update_email_send_job_batches_updated_at_step2 BEFORE UPDATE OF updated_at ON email_send_job_batches FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_same();
CREATE TRIGGER update_email_send_job_batches_updated_at_step3 BEFORE UPDATE ON email_send_job_batches FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_current();

-- email_send_job_batch_details

CREATE TABLE email_send_job_batch_details (
    job_id VARCHAR(255) NOT NULL,
    batch_id INTEGER NOT NULL,
    email_address VARCHAR(255) NOT NULL,
    retry_count INTEGER NOT NULL,
    message_id VARCHAR(255),
    status VARCHAR(32) NOT NULL,
    PRIMARY KEY(job_id, email_address, retry_count),
    failed_reason TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TRIGGER update_email_send_job_batches_updated_at_step1 BEFORE UPDATE ON email_send_job_batches FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_none();
CREATE TRIGGER update_email_send_job_batches_updated_at_step2 BEFORE UPDATE OF updated_at ON email_send_job_batches FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_same();
CREATE TRIGGER update_email_send_job_batches_updated_at_step3 BEFORE UPDATE ON email_send_job_batches FOR EACH ROW EXECUTE PROCEDURE refresh_updated_at_current();
CREATE INDEX email_send_job_batch_details_job_id_batch_id_index ON email_send_job_batch_details(job_id, batch_id);
CREATE INDEX email_send_job_batch_details_message_id_index ON email_send_job_batch_details(message_id);

-- email_send_blocked_addresses

CREATE TABLE email_send_blocked_addresses (
    email_address VARCHAR(255) NOT NULL,
    reason TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(email_address, created_at)
);

-- email_send_event_logs

CREATE TABLE email_send_logs (
    message_id VARCHAR(255),
    email_address VARCHAR(255) NOT NULL,
    event_type VARCHAR(32) NOT NULL,
    event_detail TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(message_id, created_at)
);
