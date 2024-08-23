-- Criando o banco de dados
CREATE DATABASE SistemaReservasHotel;

-- Usando o banco de dados (este comando é específico do psql)
\c SistemaReservasHotel;

-- Criando a tabela Clientes
CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    documento_identidade VARCHAR(50) UNIQUE,
    data_nascimento DATE
);

-- Criando a tabela Quartos
CREATE TABLE Quartos (
    id_quarto SERIAL PRIMARY KEY,
    numero_quarto VARCHAR(10) UNIQUE NOT NULL,
    tipo_quarto VARCHAR(50) NOT NULL,
    preco_diaria NUMERIC(10, 2) NOT NULL,
    descricao TEXT,
    status VARCHAR(20) DEFAULT 'disponível',
    CONSTRAINT status_quarto_check CHECK (status IN ('disponível', 'reservado', 'manutenção'))
);

-- Criando a tabela Reservas
CREATE TABLE Reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES Clientes(id_cliente),
    id_quarto INT REFERENCES Quartos(id_quarto),
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'reservado',
    data_reserva TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT status_reserva_check CHECK (status IN ('reservado', 'cancelado', 'concluído'))
);

-- Criando a tabela Pagamentos
CREATE TABLE Pagamentos (
    id_pagamento SERIAL PRIMARY KEY,
    id_reserva INT REFERENCES Reservas(id_reserva),
    valor_pagamento NUMERIC(10, 2) NOT NULL,
    metodo_pagamento VARCHAR(50),
    data_pagamento TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pendente',
    CONSTRAINT status_pagamento_check CHECK (status IN ('pendente', 'pago', 'cancelado'))
);