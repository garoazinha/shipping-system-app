Sistema de fretes <br>
Rodar comando db:seeds para criar um usuário administrador (Nome: Mari, E-mail: mari@sistemadefrete.com.br, Senha: password), um usuário regular (Nome: Pedro, E-mail: pedro@sistemadefrete.com.br, Senha: password), duas modalidades de transporte, e quatro veículos <br>

Aplicação que possibilita a criação, edição e desativação de modalidades de transporte, mas só para usuários autenticados e que estão marcados como administradores. <br>
Podem ser configurados os prazos estimados de entrega para uma modalidade de transporte. Assim que os intervalos são configurados, é possível atualizar o prazo estimado para tal intervalo. Para mudar os intervalos é necessário desabilitar todas os prazos e intervalos ativos. Também podem ser configuradas as taxas baseadas na distância total da entrega, considerando também intervalos. Para trocar intervalos pré-estabelecidos é necessário deletar todos os intervalos. O mesmo foi feito para as taxas baseadas em peso.

Um usuário não autenticado e um usuário regular podem ver as modalidades de transporte. 

Aplicação também possibilita a criação, edição e associação a modalidades de transporte de veículos, que devem ter informação de placa de identificação, marca, modelo, ano e capacidade máxima. 
É possível ainda associar diversas modalidades de transporte a um veículo.

Um usuário administrador pode criar uma ordem de serviço, que deve conter dois endereços, um de retirada e um de destino. Ao criar a ordem de serviço um código é criado automaticamente. 

Um usuário autenticado pode inicializar ordens de serviço selecionando a modalidade de transporte. Um usuário também pode fechar ordens de serviço.

As atividades foram gerenciadas através de um quadro no [Trello](https://trello.com/b/curhUqaO/sistema-de-fretes)

<br>

