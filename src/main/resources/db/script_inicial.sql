-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE PRODUTO (
                         NU_PRODUTO int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL,
                         CO_PRODUTO varchar(3) NOT NULL,
                         NO_PRODUTO varchar(40) NOT NULL,
                         DE_PRODUTO varchar(100),
                         VR_CONSUMO_MENSAL_ESTIMADO numeric(11, 2),
                         CONSTRAINT PK_PRODUTO PRIMARY KEY (NU_PRODUTO),
                         CONSTRAINT AK_PRODUTO UNIQUE(CO_PRODUTO)
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE PLANO_PRODUTO (
                               NU_PLANO_PRODUTO int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL,
                               NU_PRODUTO int NOT NULL,
                               CO_PLANO_PRODUTO varchar(7) NOT NULL,
                               NO_PLANO_PRODUTO varchar(40) NOT NULL,
                               CONSTRAINT PK_PLANO_PRODUTO PRIMARY KEY (NU_PLANO_PRODUTO),
                               CONSTRAINT AK_PLANO_PRODUTO UNIQUE(CO_PLANO_PRODUTO),
                               CONSTRAINT FK_PLANO_PRODUTO FOREIGN KEY (NU_PRODUTO) REFERENCES PRODUTO (NU_PRODUTO)
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE SERVICO (
                         NU_SERVICO int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL,
                         CO_SERVICO varchar(10) NOT NULL,
                         NO_SERVICO varchar(100) NOT NULL,
                         CONSTRAINT PK_SERVICO PRIMARY KEY (NU_SERVICO),
                         CONSTRAINT AK_SERVICO UNIQUE(CO_SERVICO)
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE PLANO_SERVICO (
                               NU_PLANO_PRODUTO int NOT NULL,
                               NU_SERVICO int NOT NULL,
                               VR_PLANO_SERVICO numeric(11, 2),
                               CONSTRAINT PK_PPGTB004 PRIMARY KEY (NU_PLANO_PRODUTO, NU_SERVICO),
                               CONSTRAINT FK_PLANO_SERVICO_PLANO_PRODUTO FOREIGN KEY (NU_PLANO_PRODUTO) REFERENCES PLANO_PRODUTO (NU_PLANO_PRODUTO),
                               CONSTRAINT FK_PLANO_SERVICO_SERVICO FOREIGN KEY (NU_SERVICO) REFERENCES SERVICO (NU_SERVICO)
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE FORMA_PAGAMENTO (
                                 NU_FORMA_PAGAMENTO int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL,
                                 NO_FORMA_PAGAMENTO varchar(30) NOT NULL,
                                 CONSTRAINT PK_FORMA_PAGAMENTO PRIMARY KEY (NU_FORMA_PAGAMENTO),
                                 CONSTRAINT AK_FORMA_PAGAMENTO UNIQUE(NO_FORMA_PAGAMENTO)
);

-- SQLINES DEMO *** ---------- STATUS ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE STATUS (
                        NU_STATUS int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL,
                        CO_STATUS varchar(3) NOT NULL,
                        NO_STATUS varchar(50) NOT NULL,
                        CONSTRAINT PK_STATUS PRIMARY KEY (NU_STATUS),
                        CONSTRAINT AK_STATUS UNIQUE(CO_STATUS)
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
INSERT INTO STATUS(CO_STATUS, NO_STATUS) VALUES
                                             ('SAV', 'Salva'),
                                             ('DEL', 'Excluída'),
                                             ('EXP', 'Expirada'),
                                             ('BUY', 'Comprada'),
                                             ('ERR', 'Errada');
-- SQLINES DEMO *** -------------------------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE CLIENTE (
                         NU_CLIENTE int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL,
                         NU_DOCUMENTO_CLIENTE numeric(14,0) NOT NULL,
                         NO_CLIENTE varchar(200) NOT NULL,
                         VR_RENDA_MENSAL numeric(11,2) NULL,
                         NU_CEP numeric(8,0) NOT NULL,
                         DE_COMPLEMENTO_ENDERECO  varchar(53) NULL,
                         NO_LOGRADOURO varchar(40) NULL,
                         NO_MUNICIPIO varchar(35) NULL,
                         NO_BAIRRO varchar(40) NULL,
                         SG_UF varchar(2) NULL,
                         CO_NUMERO_ENDERECO varchar(10) NULL,
                         CONSTRAINT PK_CLIENTE PRIMARY KEY (NU_CLIENTE),
                         CONSTRAINT AK_CLIENTE UNIQUE (NU_DOCUMENTO_CLIENTE)
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE PROPOSTA (
                          NU_PROPOSTA int GENERATED ALWAYS AS IDENTITY (START WITH 1  INCREMENT BY 1) NOT NULL,
                          NU_CLIENTE int NOT NULL,
                          NU_PLANO_PRODUTO int NOT NULL,
                          NU_FORMA_PAGAMENTO int NOT NULL,
                          QT_PRODUTO numeric(4, 0) NOT NULL,
                          DD_DIA_VENCIMENTO numeric(2, 0) NOT NULL,
                          CO_PROTOCOLO_PROPOSTA varchar(50),
                          DT_CRIACAO_PROPOSTA date NOT NULL,
                          DT_EXPIRACAO_PROPOSTA date,
                          CONSTRAINT PK_PROPOSTA PRIMARY KEY (NU_PROPOSTA),
                          CONSTRAINT FK_PROPOSTA_CLIENTE FOREIGN KEY (NU_CLIENTE) REFERENCES CLIENTE (NU_CLIENTE),
                          CONSTRAINT FK_PROPOSTA_PLANO_PRODUTO FOREIGN KEY (NU_PLANO_PRODUTO) REFERENCES PLANO_PRODUTO  (NU_PLANO_PRODUTO),
                          CONSTRAINT FK_PROPOSTA_FORMA_PAGAMENTO FOREIGN KEY (NU_FORMA_PAGAMENTO) REFERENCES FORMA_PAGAMENTO (NU_FORMA_PAGAMENTO)
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE STATUS_PROPOSTA (
                                 NU_STATUS int NOT NULL,
                                 NU_PROPOSTA int,
                                 DH_STATUS_PROPOSTA date NOT NULL,
                                 DE_COMENTARIO_STATUS_PROPOSTA varchar(1000),
                                 CONSTRAINT PK_STATUS_PROPOSTA PRIMARY KEY (NU_PROPOSTA, NU_STATUS, DH_STATUS_PROPOSTA),
                                 CONSTRAINT FK_STATUS_PROPOSTA_STATUS FOREIGN KEY (NU_STATUS) REFERENCES STATUS (NU_STATUS),
                                 CONSTRAINT FK_STATUS_PROPOSTA_PROPOSTA FOREIGN KEY (NU_PROPOSTA) REFERENCES PROPOSTA  (NU_PROPOSTA),
                                 CONSTRAINT AK_STATUS_PROPOSTA UNIQUE(NU_PROPOSTA, NU_STATUS, DH_STATUS_PROPOSTA)
);