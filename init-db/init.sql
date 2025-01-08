-- Création des tables pour la base de données `fractional_ownership`

-- Table des utilisateurs
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(100) NOT NULL,
                       email VARCHAR(150) UNIQUE NOT NULL,
                       wallet_balance DECIMAL(10, 2) DEFAULT 0.0 NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des propriétés
CREATE TABLE properties (
                            id SERIAL PRIMARY KEY,
                            name VARCHAR(100) NOT NULL,
                            price DECIMAL(12, 2) NOT NULL,
                            funding_progress DECIMAL(12, 2) DEFAULT 0.0 NOT NULL,
                            funding_deadline DATE NOT NULL,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des investissements
CREATE TABLE investments (
                             id SERIAL PRIMARY KEY,
                             user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                             property_id INT NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
                             amount DECIMAL(12, 2) NOT NULL,
                             percentage_owned DECIMAL(5, 2) NOT NULL,
                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des paiements
CREATE TABLE payments (
                          id SERIAL PRIMARY KEY,
                          user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                          amount DECIMAL(12, 2) NOT NULL,
                          payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          payment_status VARCHAR(50) DEFAULT 'PENDING',
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des notifications
CREATE TABLE notifications (
                               id SERIAL PRIMARY KEY,
                               user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                               message TEXT NOT NULL,
                               sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               is_read BOOLEAN DEFAULT FALSE
);

-- feed the database with some data

database fractional_ownership;

INSERT INTO users (name, email, wallet_balance)
VALUES ('John Doe', 'john.doe@example.com', 1000.00);

INSERT INTO properties (name, price, funding_deadline)
VALUES ('Luxury Apartment', 100000.00, '2025-12-31');

INSERT INTO investments (user_id, property_id, amount, percentage_owned)
VALUES (1, 1, 5000.00, 5.00);