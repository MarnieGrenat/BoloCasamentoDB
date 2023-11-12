# BoloCasamentoDB - Banco de Dados para Estatuetas de Casamento
## Autores
Autores: [Gabriela Dellamora Paim](https://github.com/MarnieGrenat), [Alessandro Eduardo dos Santos Sant'anna](https://github.com/sant-prog)

Versão: 2023.11.1

## Resumo
Este repositório contém o script SQL para um sistema de gerenciamento de banco de dados para uma loja de e-commerce especializada em estatuetas personalizadas para bolos de casamento.

## Estrutura do Banco de Dados
Clientes: Detalhes sobre os clientes que fazem pedidos.
Artistas: Informações sobre os artistas contratados pela empresa.
Endereços: Registra endereços para clientes, artistas e fornecedores.
Materiais: Informações sobre os materiais usados na produção das estatuetas.
Fornecedores: Detalhes sobre os fornecedores de materiais.
PedidosFornecimento: Registra pedidos de materiais feitos aos fornecedores.
Estatuetas: Modelos de estatuetas disponíveis.
PedidosClientes: Detalhes sobre os pedidos feitos pelos clientes.

## Funcionalidades
CHECK CONSTRAINT: Garante que a quantidade em estoque de materiais não seja negativa.
TRIGGER: Atualiza a quantidade em estoque de materiais após a conclusão de um pedido do cliente.

#Instruções de Uso
Execute o script SQL no seu SGBD Oracle.
Explore as consultas de exemplo fornecidas para análise e teste.
