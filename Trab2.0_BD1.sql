/*URL: https://github.com/ElderHenhique/Modelo_Relacional_SQL.git*/

DROP TABLE IF EXISTS TRABALHAM;
DROP TABLE IF EXISTS REGIAO;
DROP TABLE IF EXISTS REALIZAM;
DROP TABLE IF EXISTS FORNECEDORES;
DROP TABLE IF EXISTS ENTREGA;
DROP TABLE IF EXISTS VENDAS;
DROP TABLE IF EXISTS CLIENTES;
DROP TABLE IF EXISTS PROD_ORGANICOS;
DROP TABLE IF EXISTS PROD_INDUSTRIAIS;
DROP TABLE IF EXISTS CONTEM;
DROP TABLE IF EXISTS PRODUTOS;
DROP TABLE IF EXISTS TEM;
DROP TABLE IF EXISTS SETORES;
DROP TABLE IF EXISTS TRABALHAM_NO;
DROP TABLE IF EXISTS DURACAO;
DROP TABLE IF EXISTS DEPARTAMENTO;
DROP TABLE IF EXISTS FUNCIONARIOS;

CREATE TABLE DURACAO(
	id_duracao INTEGER,
    desde VARCHAR(50),
    ate VARCHAR(50),
    PRIMARY KEY(id_duracao)
);

CREATE TABLE FUNCIONARIOS(
	cpf CHAR(11),
    nome VARCHAR(100),
    cargo VARCHAR(100),
    PRIMARY KEY(cpf)
);

CREATE TABLE DEPARTAMENTO(
	id_depart INTEGER,
    orcamento REAL,
    nome VARCHAR(100),
    PRIMARY KEY(id_depart)
);

CREATE TABLE TRABALHAM_NO(
	cpf CHAR(11),
	id_depart INTEGER,
    id_duracao INTEGER,
    PRIMARY KEY (cpf, id_depart, id_duracao),
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIOS(cpf),
    FOREIGN KEY (id_depart) REFERENCES DEPARTAMENTO(id_depart),
    FOREIGN KEY (id_duracao) REFERENCES DURACAO(id_duracao)
);

CREATE TABLE SETORES(
	tipo_de_produto VARCHAR(100),
    nome VARCHAR(100),
    informacoes VARCHAR(200),
    PRIMARY KEY(tipo_de_produto)
);

CREATE TABLE TEM(
	id_depart INTEGER,
    tipo_de_produto VARCHAR(100),
    PRIMARY KEY (id_depart, tipo_de_produto),
    FOREIGN KEY (id_depart) REFERENCES DEPARTAMENTO(id_depart), 
    FOREIGN KEY (tipo_de_produto) REFERENCES SETORES(tipo_de_produto)
);

CREATE TABLE PRODUTOS(
	codigo INTEGER,
    nome VARCHAR(100),
    preco REAL,
    PRIMARY KEY(codigo)
);

CREATE TABLE CONTEM(
	codigo INTEGER,
    tipo_de_produto VARCHAR(100),
    PRIMARY KEY (codigo, tipo_de_produto),
    FOREIGN KEY (codigo) REFERENCES PRODUTOS(codigo), 
    FOREIGN KEY (tipo_de_produto) REFERENCES SETORES(tipo_de_produto)
);

CREATE TABLE PROD_ORGANICOS(
	codigo INTEGER,
	selo VARCHAR(50),
	FOREIGN KEY (codigo) REFERENCES PRODUTOS(codigo) ON DELETE CASCADE,
    PRIMARY KEY (codigo)
);

CREATE TABLE PROD_INDUSTRIAIS(
	codigo INTEGER,
	lista_agrotoxicos VARCHAR(150),
    porcetagem_agrotoxicos REAL,
    FOREIGN KEY (codigo) REFERENCES PRODUTOS(codigo) ON DELETE CASCADE,
    PRIMARY KEY (codigo)
);

CREATE TABLE CLIENTES(
	cpf CHAR(11),
    codigo INTEGER,
    nome VARCHAR(100),
    sexo char(1),
    FOREIGN KEY (codigo) REFERENCES PRODUTOS(codigo),
    PRIMARY KEY(cpf)
);

CREATE TABLE VENDAS(
	id INTEGER,
    cpf CHAR(11),
    informacoes VARCHAR(100),
    preco REAL,
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIOS(cpf),
    PRIMARY KEY(id)
);

CREATE TABLE ENTREGA(
	id INTEGER,
	cod INTEGER , 
    destinatario VARCHAR(100),
    endereco VARCHAR(100),
    FOREIGN KEY (id) REFERENCES VENDAS(id) ON DELETE CASCADE,
    PRIMARY KEY (id, destinatario)
);

CREATE TABLE FORNECEDORES(
	cod_forn INTEGER,
    localizacao VARCHAR(100),
    nome VARCHAR(100),
    PRIMARY KEY(cod_forn, localizacao)
);

CREATE TABLE REALIZAM(
	cod_forn INTEGER,
    id INTEGER,
	PRIMARY KEY (cod_forn, id),
    FOREIGN KEY (cod_forn) REFERENCES FORNECEDORES(cod_forn), 
    FOREIGN KEY (id) REFERENCES VENDAS(id)
);

CREATE TABLE REGIAO(
	endereco VARCHAR(100),
    nome VARCHAR(100),
    clima VARCHAR(100),
    PRIMARY KEY(endereco)
);

CREATE TABLE TRABALHAM(
	cod_forn INTEGER,
	endereco VARCHAR(100),
	PRIMARY KEY (cod_forn, endereco),
    FOREIGN KEY (cod_forn) REFERENCES FORNECEDORES(cod_forn), 
    FOREIGN KEY (endereco) REFERENCES REGIAO(endereco)
);

INSERT INTO FUNCIONARIOS(cpf, nome, cargo) VALUES (12345678901, 'Rodrigo', 'Atendente de caixa'), (98765432109, 'Ana','Gerente'),(67664381001, 'Marcelo', 'Repositor de Mercadorias');
INSERT INTO DURACAO(id_duracao, desde, ate) VALUES (001, '12-01-2000','30-09-2013'), (047, '25-11-2002','30-09-2010'),(050, '16-06-2007','05-02-2011');
INSERT INTO DEPARTAMENTO(id_depart, orcamento, nome) VALUES (1, 37.580, 'Super_Muffato'),(2, 38.300, 'Super_Muffato');
INSERT INTO SETORES(tipo_de_produto, nome, informacoes) VALUES ('Bebidas', 'Coca-Cola', 'Compre uma leve duas'), ('Padaria', 'Pão_Francês', 'Fresco e feito na hora');
INSERT INTO PRODUTOS(codigo, nome, preco) VALUES (20, 'Achocalatado Nescau', 7.40),(189, 'Cerveja Heineken', 6.15),(199, 'Detergente', 3.59);
INSERT INTO CLIENTES(cpf, nome, sexo) VALUES (14687635904, 'Sabrina', 'F') , (56389100460, 'Roberto', 'M'),(15477219804, 'Amanda', 'F');
INSERT INTO VENDAS(id, informacoes, preco) VALUES (0029, 'Pagamento_Em_Dinheiro', 225.59) , (0030, 'Pagamento_No_Cartão', 413.07),(0031, 'Pagamento_Em_Dinheiro', 50.99);
INSERT INTO FORNECEDORES(cod_forn, localizacao, nome) VALUES (012386, 'Penápolis_SP', 'Megafort'),(098216, 'Curitiba_PR', 'Oesa');
INSERT INTO REGIAO(endereco, nome, clima) VALUES ('Maringá_PR', 'SUL','SubTropical') , ('Campinas_SP','Sudeste','Tropical');

