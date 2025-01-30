-- Tabela Paciente
CREATE TABLE Paciente (
    Codigo SERIAL PRIMARY KEY, -- SERIAL serve para autoincremento
    NomeCompleto VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Endereco VARCHAR(200),
    Telefone VARCHAR(15),
    Email VARCHAR(100) UNIQUE NOT NULL,
    DataNascimento DATE NOT NULL,
    Senha VARCHAR(10) NOT NULL CHECK (LENGTH(Senha) BETWEEN 5 AND 10),
    PossuiPlanoSaude BOOLEAN NOT NULL
);

-- Tabela Medico
CREATE TABLE Medico (
    CRM VARCHAR(20) PRIMARY KEY,
    NomeCompleto VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Endereco VARCHAR(200),
    Telefone VARCHAR(15),
    Email VARCHAR(100) UNIQUE NOT NULL,
    DataNascimento DATE NOT NULL
);

-- Tabela Especialidade
CREATE TABLE Especialidade (
    Identificador SERIAL PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL
);

-- Tabela de Relacionamento Medico_Especialidade
CREATE TABLE Medico_Especialidade (
    CRM VARCHAR(20),
    IdentificadorEspecialidade INT,
    PRIMARY KEY (CRM, IdentificadorEspecialidade),
    FOREIGN KEY (CRM) REFERENCES Medico(CRM) ON DELETE CASCADE,
    FOREIGN KEY (IdentificadorEspecialidade) REFERENCES Especialidade(Identificador) ON DELETE CASCADE
);

-- Tabela Agendamento
CREATE TABLE Agendamento (
    Codigo SERIAL PRIMARY KEY,
    DataHoraAgendamento TIMESTAMP NOT NULL,
    DataHoraConsulta TIMESTAMP NOT NULL,
    ValorPrevisto DECIMAL(10, 2) NOT NULL,
    CodigoPaciente INT,
    CRMMedico VARCHAR(20),
    FOREIGN KEY (CodigoPaciente) REFERENCES Paciente(Codigo) ON DELETE CASCADE,
    FOREIGN KEY (CRMMedico) REFERENCES Medico(CRM) ON DELETE CASCADE
);