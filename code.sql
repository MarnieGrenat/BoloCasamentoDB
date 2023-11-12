-- Grupo C
-- Alessandro Eduardo dos Santos Sant'Anna. Matrícula: 22111200
-- Gabriela Dellamora Paim. Matrícula: 22107680

-- Criação das tabelas

-- Tabela de Clientes
CREATE TABLE Clientes (
    id_cliente NUMBER PRIMARY KEY,
    nome VARCHAR2(50) NOT NULL,
    endereco_id NUMBER,
    contato VARCHAR2(20)
);

-- Tabela de Artistas
CREATE TABLE Artistas (
    id_artista NUMBER PRIMARY KEY,
    nome VARCHAR2(50) NOT NULL,
    contato VARCHAR2(20)
);

-- Tabela de Endereços
CREATE TABLE Enderecos (
    id_endereco NUMBER PRIMARY KEY,
    rua VARCHAR2(50),
    numero VARCHAR2(10),
    cidade VARCHAR2(50),
    cep VARCHAR2(10)
);

-- Tabela de Materiais
CREATE TABLE Materiais (
    id_material NUMBER PRIMARY KEY,
    nome_material VARCHAR2(50) NOT NULL,
    quantidade_em_estoque NUMBER
);

-- Tabela de Fornecedores
CREATE TABLE Fornecedores (
    id_fornecedor NUMBER PRIMARY KEY,
    nome_fornecedor VARCHAR2(50) NOT NULL,
    contato VARCHAR2(20)
);

-- Tabela de Pedidos de Fornecimento
CREATE TABLE PedidosFornecimento (
    id_pedido NUMBER PRIMARY KEY,
    id_fornecedor NUMBER,
    data_pedido DATE,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

-- Tabela de Estatuetas
CREATE TABLE Estatuetas (
    id_estatua NUMBER PRIMARY KEY,
    pose VARCHAR2(50) NOT NULL,
    tamanho VARCHAR2(20),
    estilo VARCHAR2(50),
    id_artista NUMBER,
    FOREIGN KEY (id_artista) REFERENCES Artistas(id_artista)
);

-- Tabela de Pedidos de Clientes
CREATE TABLE PedidosClientes (
    id_pedido_cliente NUMBER PRIMARY KEY,
    id_cliente NUMBER,
    id_estatua NUMBER,
    cor_personalizada VARCHAR2(20),
    caracteristicas_especificas VARCHAR2(100),
    status_producao VARCHAR2(50),
    codigo_rastreamento VARCHAR2(20),
    data_envio DATE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_estatua) REFERENCES Estatuetas(id_estatua)
);

-- Criação de CHECK CONSTRAINT

-- Verifica se a quantidade em estoque de materiais é não negativa
ALTER TABLE Materiais
ADD CONSTRAINT check_quantidade_estoque_non_negative CHECK (quantidade_em_estoque >= 0);

-- Criação de TRIGGER

-- Atualiza a quantidade em estoque de materiais após a conclusão de um pedido do cliente
CREATE OR REPLACE TRIGGER atualiza_quantidade_estoque
AFTER INSERT ON PedidosClientes
FOR EACH ROW
BEGIN
    UPDATE Materiais SET quantidade_em_estoque = quantidade_em_estoque - 1 WHERE id_material = :NEW.id_material;
END;
/

-- Inserção de Dados

-- Inserir clientes
INSERT INTO Clientes VALUES (1, 'Cliente1', 1, '123456789');
INSERT INTO Clientes VALUES (2, 'Cliente2', 2, '987654321');

-- Inserir artistas
INSERT INTO Artistas VALUES (1, 'Artista1', '987654321');
INSERT INTO Artistas VALUES (2, 'Artista2', '123456789');

-- Inserir endereços
INSERT INTO Enderecos VALUES (1, 'Rua A', '123', 'Cidade A', '12345-678');
INSERT INTO Enderecos VALUES (2, 'Rua B', '456', 'Cidade B', '98765-432');

-- Inserir materiais
INSERT INTO Materiais VALUES (1, 'Material1', 50);
INSERT INTO Materiais VALUES (2, 'Material2', 30);

-- Inserir fornecedores
INSERT INTO Fornecedores VALUES (1, 'Fornecedor1', '111222333');
INSERT INTO Fornecedores VALUES (2, 'Fornecedor2', '444555666');

-- Inserir pedidos de fornecimento
INSERT INTO PedidosFornecimento VALUES (1, 1, SYSDATE);
INSERT INTO PedidosFornecimento VALUES (2, 2, SYSDATE);

-- Inserir estatuetas
INSERT INTO Estatuetas VALUES (1, 'Pose1', 'Pequeno', 'Estilo1', 1);
INSERT INTO Estatuetas VALUES (2, 'Pose2', 'Grande', 'Estilo2', 2);

-- Inserir pedidos de clientes
INSERT INTO PedidosClientes VALUES (1, 1, 1, 'Branco', 'Detalhes1', 'Em Producao', 'ABCDE123', NULL);
INSERT INTO PedidosClientes VALUES (2, 2, 2, 'Preto', 'Detalhes2', 'Concluido', 'FGHIJ456', SYSDATE);

-- Consultas

-- Consulta 1
SELECT c.nome, e.rua, p.pose
FROM Clientes c
JOIN Enderecos e ON c.endereco_id = e.id_endereco
JOIN PedidosClientes pc ON c.id_cliente = pc.id_cliente
JOIN Estatuetas p ON pc.id_estatua = p.id_estatua
WHERE pc.status_producao = 'Em Producao'
ORDER BY c.nome;

-- Consulta 2
SELECT nome, contato
FROM Artistas
WHERE id_artista IN (SELECT id_artista FROM Estatuetas WHERE tamanho = 'Grande');

-- Consulta 3
SELECT f.nome_fornecedor, m.nome_material
FROM Fornecedores f
JOIN PedidosFornecimento pf ON f.id_fornecedor = pf.id_fornecedor
JOIN Materiais m ON pf.id_material = m.id_material
WHERE pf.data_pedido > TO_DATE('2023-09-01', 'YYYY-MM-DD');
