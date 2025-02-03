-- Tabela Pessoa: Contém os dados das pessoas que podem ser paciente e/ou médicos.
CREATE TABLE Pessoa (
    cpf CHAR(11) PRIMARY KEY,
    email VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(150) UNIQUE NOT NULL,
    data_nasc DATE NOT NULL,
    endereco VARCHAR(300) NOT NULL, -- Endereço contendo: cep, rua, número e complemento
    telefone VARCHAR(15) NULL
);

-- Tabela Paciente: Contém os dados específico das pessoas que são pacientes.
CREATE TABLE Paciente (
    -- codigo SERIAL PRIMARY KEY,
    cpf_pessoa CHAR(11) PRIMARY KEY REFERENCES Pessoa(cpf), -- CPF do paciente. Chave estrangeira referenciando o campo 'cpf" na tabela "Pessoa".
    senha VARCHAR(20) NOT NULL CHECK (LENGTH(senha) BETWEEN 5 AND 10), -- Senha do paciente para acessar o sistema.
    plano_saude BOOLEAN NOT NULL -- Indica se o paciente possui plano de saúde. O valor "1" indica que o paciente possui plano de saúde, caso contrário, "0".
);

-- Tabela Medico: Contém os dados específico das pessoas que são médicos.
CREATE TABLE Medico (
    cpf_pessoa CHAR(11) PRIMARY KEY REFERENCES Pessoa(cpf), -- CPF do médico. Chave estrangeira referenciando o campo 'cpf" na tabela "Pessoa".
    crm VARCHAR(10) UNIQUE NOT NULL -- CRM do médico
);

-- Tabela Agendamento: Contém os dados dos agendamentos
CREATE TABLE Agendamento (
    -- id SERIAL PRIMARY KEY,
    cpf_paciente CHAR(11) REFERENCES Paciente(cpf_pessoa) ON DELETE CASCADE, -- CPF do paciente. Chave estrangeira referenciando o campo 'cpf" na tabela "Paciente".
    cpf_medico CHAR(11) REFERENCES Medico(cpf_pessoa) ON DELETE CASCADE, -- CPF do médico. Chave estrangeira referenciando o campo 'cpf" na tabela "Médico".
    dh_consulta TIMESTAMP,
    dh_agendamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_consulta DECIMAL(10,2) NOT NULL CHECK (valor_consulta >= 0) DEFAULT 0.0, -- Valor da consulta. Caso o paciente possua plano de saúde, o valor armazenado é R$ 0,0.
    PRIMARY KEY (cpf_paciente, cpf_medico, dh_consulta)
);

-- Tabela Especialidade: Contém os dados das especialidades cadastradas.
CREATE TABLE Especialidade (
    id SERIAL PRIMARY KEY, -- Identificador da especialidade.
    descricao VARCHAR(300) NOT NULL -- Descreve a especialidade.
);

-- Tabela Medico_Especialidade: Contém as associações entre os médicos e as respectivas especialidades.
CREATE TABLE Medico_Especialidade (
    cpf_medico CHAR(11) REFERENCES Medico(cpf_pessoa) ON DELETE CASCADE, -- CPF do médico. Chave estrangeira referenciando o campo "cpf" na tabela "medico".
    id_especialidade INT REFERENCES Especialidade(id) ON DELETE CASCADE, -- Identificador da especialidade. Chave estrangeira referenciando o campo "identificador" na tabela "Especialidade".
    PRIMARY KEY (cpf_medico, id_especialidade)
);
