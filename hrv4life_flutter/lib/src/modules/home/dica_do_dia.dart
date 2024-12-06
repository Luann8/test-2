import 'dart:math';

// Definição das categorias
enum Category {
  sono,
  alimentacao,
  exercicio,
  saudeMental,
  saudeGeral,
}

// Classe para representar uma frase
class Phrase {
  final int id;
  final Category category;
  final String text;
  bool status;
  bool used;

  Phrase({
    required this.id,
    required this.category,
    required this.text,
    this.status = true,
    this.used = false,
  });
}

// Lista de frases
List<Phrase> phrases = [
  // Categoria: Sono
  Phrase(
      id: 101,
      category: Category.sono,
      text:
          "Rotina consistente: Vá para a cama e acorde no mesmo horário todos os dias. Evite dormir até mais tarde no fim de semana."),
  Phrase(
      id: 102,
      category: Category.sono,
      text:
          "Tenha hora para dormir: padronizar a hora de dormir pode te ajudar a ter um sono de qualidade."),
  Phrase(
      id: 103,
      category: Category.sono,
      text: "Durma tranquilo: Mantenha o quarto escuro, silencioso e fresco."),
  Phrase(
      id: 104,
      category: Category.sono,
      text:
          "Evite eletrônicos: Desligue suas telas antes de dormir para evitar a luz azul."),
  Phrase(
      id: 105,
      category: Category.sono,
      text: "Evite cafeína depois das 17h: Ela pode atrapalhar o sono."),
  Phrase(
      id: 106,
      category: Category.sono,
      text:
          "Atividade física regular: Exercite-se, mas não muito perto da hora de dormir."),
  Phrase(
      id: 107,
      category: Category.sono,
      text:
          "Evite refeições pesadas antes de dormir: Coma mais cedo para facilitar a digestão."),
  Phrase(
      id: 108,
      category: Category.sono,
      text: "Relaxe antes de dormir: Medite, leia ou tome um banho quente."),
  Phrase(
      id: 109,
      category: Category.sono,
      text: "Limite sonecas: Evite cochilos longos durante o dia."),
  Phrase(
      id: 110,
      category: Category.sono,
      text:
          "Respire lentamente antes de dormir: a respiração guiada no app pode te ajudar a acalmar antes do sono."),
  Phrase(
      id: 111,
      category: Category.sono,
      text:
          "Respeite seu relógio biológico: Durma quando estiver naturalmente cansado."),
  Phrase(
      id: 112,
      category: Category.sono,
      text:
          "Está tossindo ao deitar-se? Pode ser refluxo. Tente reduzir a cafeína e jantar mais cedo."),

  // Categoria: Alimentação
  Phrase(
      id: 201,
      category: Category.alimentacao,
      text:
          "Varie os alimentos: Consuma diferentes alimentos para obter todos os nutrientes."),
  Phrase(
      id: 202,
      category: Category.alimentacao,
      text: "Coma 3 frutas por dia: Elas são ricas em vitaminas e fibras."),
  Phrase(
      id: 203,
      category: Category.alimentacao,
      text:
          "Escolha grãos integrais: Pães e arroz integrais são mais nutritivos."),
  Phrase(
      id: 204,
      category: Category.alimentacao,
      text:
          "Controle as porções: Evite excessos e coma somente até se sentir satisfeito."),
  Phrase(
      id: 205,
      category: Category.alimentacao,
      text:
          "Inclua proteínas magras: Peito de frango, peixe e soja são boas opções."),
  Phrase(
      id: 206,
      category: Category.alimentacao,
      text:
          "Evite alimentos ultraprocessados: Prefira refeições caseiras e não industrializados."),
  Phrase(
      id: 207,
      category: Category.alimentacao,
      text:
          "Beba água: Ao menos 2 litros por dia, isso é essencial para o funcionamento do corpo."),
  Phrase(
      id: 208,
      category: Category.alimentacao,
      text:
          "Use temperos naturais: Evite excesso de sal e açúcar e use mais ervas."),
  Phrase(
      id: 209,
      category: Category.alimentacao,
      text:
          "Reduza o consumo de açúcar: principalmente de produtos industrializados."),
  Phrase(
      id: 210,
      category: Category.alimentacao,
      text:
          "Faça refeições regulares: Não pule refeições e mantenha o metabolismo ativo."),
  Phrase(
      id: 211,
      category: Category.alimentacao,
      text:
          "Evite alimentos industrializados: Prefira refeições caseiras e ingredientes naturais."),
  Phrase(
      id: 212,
      category: Category.alimentacao,
      text:
          "Inclua gorduras saudáveis: Abacate, azeite e nozes são boas opções."),
  Phrase(
      id: 213,
      category: Category.alimentacao,
      text: "Evite frituras! Prefira grelhados para proteger o coração."),
  Phrase(
      id: 214,
      category: Category.alimentacao,
      text:
          "Coma devagar: Mastigue bem para digerir melhor e ficar mais satisfeito."),
  Phrase(
      id: 215,
      category: Category.alimentacao,
      text: "Evite excesso de sódio: Reduza o sal para proteger seu coração."),
  Phrase(
      id: 216,
      category: Category.alimentacao,
      text:
          "Faça lanches saudáveis: Frutas, iogurte e castanhas são ótimas opções."),
  Phrase(
      id: 217,
      category: Category.alimentacao,
      text: "Aposte em alimentos coloridos: Mais cores, mais nutrientes."),
  Phrase(
      id: 218,
      category: Category.alimentacao,
      text:
          "Evite refrigerantes e sucos industrializados: Opte por água ou chás."),
  Phrase(
      id: 219,
      category: Category.alimentacao,
      text:
          "Planeje suas refeições: Organização ajuda a fazer escolhas melhores e a economizar no mercado."),
  Phrase(
      id: 220,
      category: Category.alimentacao,
      text:
          "Evite excesso de carne vermelha! Opte por alternativas como peixe ou frango."),
  Phrase(
      id: 221,
      category: Category.alimentacao,
      text: "Controle o sal! Menos sal ajuda a manter a pressão estável."),
  Phrase(
      id: 222,
      category: Category.alimentacao,
      text: "Evite excesso de açúcar! Cuidado com refrigerantes e doces."),
  Phrase(
      id: 223,
      category: Category.alimentacao,
      text: "Evite excesso de cafeína! Isso pode aumentar sua ansiedade."),
  Phrase(
      id: 224,
      category: Category.alimentacao,
      text: "Evite excesso de álcool! Moderação é essencial para o fígado."),
  Phrase(
      id: 225,
      category: Category.alimentacao,
      text:
          "Evite alimentos industrializados! Eles contêm aditivos e sal em excesso."),
  Phrase(
      id: 226,
      category: Category.alimentacao,
      text:
          "Coma fibras! Elas melhoram a digestão e mantêm o intestino funcionando bem. Frutas são ótimas para isso."),
  Phrase(
      id: 227,
      category: Category.alimentacao,
      text: "Evite fast food! Cozinhe em casa para escolhas mais saudáveis."),
  Phrase(
      id: 228,
      category: Category.alimentacao,
      text:
          "Evite excesso de sal! Reduza o consumo para manter a pressão saudável."),
  Phrase(
      id: 229,
      category: Category.alimentacao,
      text:
          "Coma uma dieta saudável para o coração: Alimentos ricos em fibras, proteínas magras e gorduras saudáveis podem beneficiar a saúde do coração."),
  Phrase(
      id: 230,
      category: Category.alimentacao,
      text:
          "Limite o álcool: O consumo excessivo de álcool pode aumentar a frequência cardíaca e danificar o coração."),
  Phrase(
      id: 231,
      category: Category.alimentacao,
      text:
          "Mantenha um peso saudável: O excesso de peso pode colocar pressão extra sobre o coração e afetar a frequência cardíaca."),
  Phrase(
      id: 232,
      category: Category.alimentacao,
      text:
          "Limite a cafeína: A cafeína pode aumentar sua frequência cardíaca."),
  Phrase(
      id: 233,
      category: Category.alimentacao,
      text:
          "Coma mais peixe: O peixe é rico em ômega-3, que é bom para a saúde do coração."),
  Phrase(
      id: 234,
      category: Category.alimentacao,
      text:
          "Evite dietas radicais: Elas podem afetar a saúde do coração e dificilmente você conseguirá manter por muito tempo."),

  // Categoria: Exercício
  Phrase(
      id: 301,
      category: Category.exercicio,
      text:
          "Mexa-se! Faça 30 minutos de caminhadas diárias para fortalecer músculos, ossos e diminuir o estresse."),
  Phrase(
      id: 302,
      category: Category.exercicio,
      text:
          "Alongue-se! Treinar sua flexibilidade pode te dar mais bem-estar no dia a dia."),
  Phrase(
      id: 303,
      category: Category.exercicio,
      text:
          "Acha exercício chato? Chame alguém para ir junto. Amigos deixam tudo mais agradável!"),
  Phrase(
      id: 304,
      category: Category.exercicio,
      text:
          "O melhor exercício é o que gostamos. Dessa forma não vamos desistir facilmente. Experimente e encontre o que te agrada."),
  Phrase(
      id: 305,
      category: Category.exercicio,
      text:
          "30 minutos de exercício por dia já aumentam sua expectativa de vida."),
  Phrase(
      id: 306,
      category: Category.exercicio,
      text:
          "Caminhe mais: Suba escadas em vez de usar o elevador e levante a cada 30 minutos no seu turno de trabalho."),
  Phrase(
      id: 307,
      category: Category.exercicio,
      text:
          "Hidrate-se nos dias de exercício: Beba água antes, durante e após o exercício."),
  Phrase(
      id: 308,
      category: Category.exercicio,
      text:
          "Varie os exercícios: Alterne entre cárdio e força para se manter motivado."),
  Phrase(
      id: 309,
      category: Category.exercicio,
      text:
          "Descanse: Tire um dia de descanso entre os treinos intensos. Assim você vai progredir mais rápido nos seus exercícios."),
  Phrase(
      id: 310,
      category: Category.exercicio,
      text: "Aqueça-se: Faça um aquecimento antes de começar a se exercitar."),
  Phrase(
      id: 311,
      category: Category.exercicio,
      text: "Respire corretamente: Respire profundamente durante o exercício."),
  Phrase(
      id: 312,
      category: Category.exercicio,
      text:
          "Use equipamento adequado: Use sapatos e roupas adequados e leves. Você deve estar confortável o tempo todo."),
  Phrase(
      id: 313,
      category: Category.exercicio,
      text:
          "Mantenha a postura: Preste atenção à sua postura durante o exercício. As costas retas e o peito estufado."),
  Phrase(
      id: 314,
      category: Category.exercicio,
      text:
          "Defina metas: Estabeleça metas realistas para se manter motivado a fazer exercícios."),
  Phrase(
      id: 315,
      category: Category.exercicio,
      text: "Escute seu corpo: Pare se sentir dor durante o exercício."),
  Phrase(
      id: 316,
      category: Category.exercicio,
      text:
          "Faça exercícios em grupo: Exercite-se com amigos para se divertir e se motivar."),
  Phrase(
      id: 317,
      category: Category.exercicio,
      text:
          "Experimente novos exercícios: Mantenha sua rotina de exercícios interessante e tenha novas experiencias."),
  Phrase(
      id: 318,
      category: Category.exercicio,
      text:
          "Mantenha a consistência: Faça exercícios regularmente por pelo menos 3 meses para ver resultados."),
  Phrase(
      id: 319,
      category: Category.exercicio,
      text:
          "Faça pausas: Descanse entre as séries de exercícios. O descanso permite os músculos recuperarem e evoluírem."),
  Phrase(
      id: 320,
      category: Category.exercicio,
      text:
          "Fique ativo: Tente ficar em movimento durante o dia. Levante da cadeia a cada 30 min e use escadas quando possível."),
  Phrase(
      id: 321,
      category: Category.exercicio,
      text:
          "Faça exercícios ao ar livre: Aproveite sua cidade, a natureza e saia um pouco da rotina."),

  // Categoria: Saúde Mental/Estresse
  Phrase(
      id: 401,
      category: Category.saudeMental,
      text: "Mantenha a mente curiosa! Explore novos hobbies e interesses."),
  Phrase(
      id: 402,
      category: Category.saudeMental,
      text:
          "Mantenha contato com amigos! Socializar fortalece os laços e melhora sua saúde mental."),
  Phrase(
      id: 403,
      category: Category.saudeMental,
      text: "Socialize! Amigos e familiares são essenciais para o bem-estar."),
  Phrase(
      id: 404,
      category: Category.saudeMental,
      text: "Aprecie pequenos momentos! Valorize as pequenas alegrias."),
  Phrase(
      id: 405,
      category: Category.saudeMental,
      text: "Aprenda algo novo! Estimule seu cérebro com novos conhecimentos."),
  Phrase(
      id: 406,
      category: Category.saudeMental,
      text: "Aprecie o silêncio! Momentos de paz são revigorantes."),
  Phrase(
      id: 407,
      category: Category.saudeMental,
      text:
          "Está ansioso? Relaxa e respire lentamente por 5 minutos antes de uma reunião ou situação estressante."),
  Phrase(
      id: 408,
      category: Category.saudeMental,
      text:
          "Respire conscientemente! Reduza o estresse com respiração profunda e lenta (6 respirações por minuto)"),
  Phrase(
      id: 409,
      category: Category.saudeMental,
      text:
          "Respire fundo! Relaxa e respire lentamente por 5 minutos quando estiver estressado."),
  Phrase(
      id: 410,
      category: Category.saudeMental,
      text:
          "Faça pausas no trabalho: descansado você vai render mais, errar menos e se estressar menos."),
  Phrase(
      id: 411,
      category: Category.saudeMental,
      text:
          "Faça pausas: Quando estiver cansado de uma atividade, mude seu foco de trabalho para outra atividade mais simples."),
  Phrase(
      id: 412,
      category: Category.saudeMental,
      text:
          "Pratique mindfulness: Tenha atenção plena por 10 minutos por dia em uma atividade sem se preocupar com mais nada."),
  Phrase(
      id: 413,
      category: Category.saudeMental,
      text:
          "Respire fundo: Quando estiver muito estressado ou ansioso, a respiração profunda pode ajudar a reduzir o estresse."),
  Phrase(
      id: 414,
      category: Category.saudeMental,
      text:
          "Organize seu espaço: Um ambiente limpo e organizado pode melhorar seu foco."),
  Phrase(
      id: 415,
      category: Category.saudeMental,
      text:
          "Defina metas: Definir metas claras pode ajudar na organização do tempo no seu dia a dia."),
  Phrase(
      id: 416,
      category: Category.saudeMental,
      text:
          "Evite multitarefas: Fazer uma coisa de cada vez pode melhorar o foco e diminuir seus erros e frustrações."),
  Phrase(
      id: 417,
      category: Category.saudeMental,
      text:
          "Faça listas: Listas de tarefas podem ajudar na organização do tempo."),
  Phrase(
      id: 418,
      category: Category.saudeMental,
      text:
          "Pratique o autocuidado: No seu planejamento diário, reserve um tempo para cuidar de si mesmo."),
  Phrase(
      id: 419,
      category: Category.saudeMental,
      text:
          "Mantenha uma rotina: Uma rotina diária facilita a organizar seu tempo e diminuía a ansiedade."),
  Phrase(
      id: 420,
      category: Category.saudeMental,
      text:
          "Desconecte-se: Tire um tempo longe das telas para relaxar. Principalmente se você trabalha no computador."),
  Phrase(
      id: 421,
      category: Category.saudeMental,
      text:
          "Tenha hobbies: Atividades de lazer podem ajudar a reduzir o estresse e atirar sua atenção das preocupações do trabalho."),
  Phrase(
      id: 422,
      category: Category.saudeMental,
      text:
          "Escute música: música baixa durante o trabalho ou estudo pode ajudar a reduzir o estresse e melhorar o foco."),
  Phrase(
      id: 423,
      category: Category.saudeMental,
      text:
          "Faça uma soneca: Uma soneca rápida pode ajudar a melhorar o foco, principalmente se você estiver muito cansado."),

  // Categoria: Saúde Geral
  Phrase(
      id: 501,
      category: Category.saudeGeral,
      text:
          "Cuide da postura! Evite dores nas costas e pescoço. Sente-se sem cruzar as pernas e mantenhas costas sem se curvar muito."),
  Phrase(
      id: 502,
      category: Category.saudeGeral,
      text: "Faça pausas! Descansar os olhos evita fadiga visual."),
  Phrase(
      id: 503,
      category: Category.saudeGeral,
      text:
          "Use protetor solar todo dia! Proteja sua pele dos raios UV com protetor de 30 fps ou mais."),
  Phrase(
      id: 504,
      category: Category.saudeGeral,
      text:
          "Fique ao ar livre: Passar tempo ao ar livre pode reduzir o estresse. Aproveite e faça um exercício com um amigo."),
  Phrase(
      id: 505,
      category: Category.saudeGeral,
      text:
          "Monitore sua frequência cardíaca: Conhecer sua frequência cardíaca diariamente pode ajudar a avaliar sua saúde cardíaca."),
  Phrase(
      id: 506,
      category: Category.saudeGeral,
      text:
          "Faça check-ups regulares: Exames regulares podem ajudar a detectar problemas cardíacos precocemente."),
  Phrase(
      id: 507,
      category: Category.saudeGeral,
      text:
          "Conheça seu histórico familiar: Condições cardíacas podem ser hereditárias. Conheça as doenças dos seus familiares."),
  Phrase(
      id: 508,
      category: Category.saudeGeral,
      text:
          "Controle a pressão: A hipertensão pode causar danos ao coração ao longo do tempo. Então nunca pare de tomar seu remédio."),
  Phrase(
      id: 509,
      category: Category.saudeGeral,
      text:
          "Faça exames regulares: Eles podem ajudar a detectar doenças antes de ficarem sérias."),
];

// Função para sortear uma frase aleatória
Phrase? getDailyTip() {
  // Filtrar frases disponíveis
  var availablePhrases = phrases.where((p) => p.status && !p.used).toList();

  if (availablePhrases.isEmpty) {
    // Resetar todas as frases para não usadas se todas já foram usadas
    for (var phrase in phrases) {
      phrase.used = false;
    }
    availablePhrases = phrases.where((p) => p.status).toList();
  }

  if (availablePhrases.isEmpty) return null;

  // Agrupar frases por categoria
  var phrasesByCategory = groupBy(availablePhrases, (Phrase p) => p.category);

  // Escolher uma categoria aleatória
  var randomCategory = phrasesByCategory.keys
      .elementAt(Random().nextInt(phrasesByCategory.length));

  // Escolher uma frase aleatória da categoria escolhida
  var randomPhrase = phrasesByCategory[randomCategory]![
      Random().nextInt(phrasesByCategory[randomCategory]!.length)];

  // Marcar a frase como usada
  randomPhrase.used = true;
  return randomPhrase;
}

// Função auxiliar para agrupar lista
Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
  var map = <T, List<S>>{};
  for (var element in values) {
    (map[key(element)] ??= []).add(element);
  }
  return map;
}
