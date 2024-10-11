#1: CRIAR BANCO DE DADOS (SCHEMA OU DATABASE)
create schema estudodecaso1_BD;

#USAR O BANCO DE DADOS
USE estudodecaso1_BD;

#3: CRIAR AS TABELAS NORMAIS
CREATE TABLE IF NOT EXISTS FORNECEDORES(
#Nome do atributo, tipo, restrição de integridade (ordem)
 
FORNEC_COD INT PRIMARY KEY, 
FORNEC_NOME VARCHAR(45) NOT NULL, 
FORNEC_RUA VARCHAR (45) NOT NULL,
FORNEC_NUMRUA VARCHAR (45) NOT NULL,
FORNEC_BAIRRO VARCHAR (45) NOT NULL,
FORNEC_CIDADE VARCHAR (45) NOT NULL,
FORNEC_ESTADO VARCHAR (45) NOT NULL,
FORNEC_PAIS VARCHAR (30) NOT NULL,
FORNEC_CODPOSTAL VARCHAR (10) NOT NULL,
FORNEC_TELEFONE VARCHAR (15) NOT NULL,
FORNEC_CONTATO TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS FILIAIS (

FILIAIS_COD INT PRIMARY KEY,
FILIAIS_NOME VARCHAR (30) NOT NULL,
FILIAIS_RUA VARCHAR (100) NOT NULL,
FILIAIS_NUMRUA INT NOT NULL,
FILIAIS_BAIRRO VARCHAR (50) NOT NULL, 
FILIAIS_CIDADE VARCHAR (50) NOT NULL, 
FILIAIS_ESTADO VARCHAR (50) NOT NULL, 
FILIAIS_PAÍS VARCHAR (50) NOT NULL, 
FILIAIS_CODPOSTAL VARCHAR (10) NOT NULL, 
FILIAIS_CAPACIDADE TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS PRODUTOS ( 

PRODUTOS_COD INT PRIMARY KEY,
PRODUTOS_NOME VARCHAR (100) NOT NULL,
PRODUTOS_DESCRIÇÃO TEXT NOT NULL,
PRODUTOS_ESPECTEC TEXT NOT NULL,
PRODUTOS_QUANT DECIMAL (10,3) NOT NULL,
PRODUTOS_PRECOUNIT DECIMAL (10,2) NOT NULL, 
PRODUTOS_UNIMED VARCHAR (10) NOT NULL,
PRODUTOS_ESTOQMÍN DECIMAL (10,3) NOT NULL
);

#4: CRIAR TABELAS COM AS FK's
CREATE TABLE IF NOT EXISTS PEDIDOS ( 

PEDIDOS_COD INT PRIMARY KEY,
PEDIDOS_DATA DATE NOT NULL,
PEDIDOS_HORA TIME NOT NULL,
PEDIDOS_PREVISÃO DATE NOT NULL,
PEDIDOS_STATUS ENUM('PENDENTE', 'CONCLUÍDO', 'EM ESPERA'),
PED_FORNECEDOR INT NOT NULL,
CONSTRAINT FK_FORNECEDOR FOREIGN KEY (PED_FORNECEDOR) #DAR NOME A RESTRIÇÃO(CONSTRAINT) É UMA BOA IDEIA
REFERENCES FORNECEDORES (FORNEC_COD)
);

CREATE TABLE IF NOT EXISTS RECEBIMENTOS (
#VEM DEPOIS PORQUE TEM DEPENDENCIA DE PEDIDOS
RECEB_DATA DATE NOT NULL,
RECEB_HORA TIME NOT NULL,
RECEB_QUANT_PROD DECIMAL(10,3),
RECEB_CONDIC TEXT NOT NULL,
RECB_PEDIDOS INT PRIMARY KEY,
CONSTRAINT FK_PEDIDOS FOREIGN KEY (RECEB_PEDIDOS) REFERENCES PEDIDOS(PEDIDOS_COD)
);

#5: CRIAR AS ENTIDADES ASSOCIATIVAS

CREATE TABLE IF NOT EXISTS PEDIDOS_PRODUTOS (
PDPR_PEDIDOS INT, 
PDPR_PRODUTOS INT, 
PRIMARY KEY(PDPR_PEDIDOS, PDPR_PRODUTOS),
PDPR_QUANT DECIMAL(10,3) NOT NULL,
CONSTRAINT PDPR_FK_PEDIDOS FOREIGN KEY(PDPR_PEDIDOS) REFERENCES PEDIDOS (PEDIDOS_COD),
CONSTRAINT PDPR_FK_PRODUTOS FOREIGN KEY (PDPR_PRODUTOS) REFERENCES PRODUTOS (PRODUTOS_COD)
);

CREATE TABLE IF NOT EXISTS FORNEC_PRODUTOS (
FRPR_FORNECEDORES INT, 
FRPR_PRODUTOS INT, 
PRIMARY KEY(FRPR_FORNEC, FRPR_PRODUTOS),
CONSTRAINT FRPR_FK_FORNEC FOREIGN KEY (FRPR_FORNECEDOR) REFERENCES FORNECEDORES (FORNEC_COD),
CONSTRAINT FRPR_FK_PRODUTOS FOREIGN KEY (FRPR_PRODUTOS) REFERENCES PRODUTOS (PRODUTOS_COD)
);

CREATE TABLE IF NOT EXISTS FILIAIS_PRODUTOS (
FILPR_FILAIS INT,
FILPR_PRODUTOS INT, 
PRIMARY KEY (FILPR_FILAIS, FILPR_PRODUTOS),
CONSTRAINT FILPR_FK_FILIAIS FOREIGN KEY (FILPR_FILAIS) REFERENCES FILIAIS (FILIAIS_COD),
CONSTRAINT FILPR_FK_PRODUTOS FOREIGN KEY (FILPR_PRODUTOS) REFERENCES PRODUTOS (PRODUTOS_COD)
);