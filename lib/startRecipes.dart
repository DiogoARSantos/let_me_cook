import 'package:let_me_cook/models/Recipe.dart';
import 'package:let_me_cook/models/Ingredient.dart';

List<Recipe> startRecipeList = [
  Recipe(
    title: "Panquecas",
    portions: 4,
    duration: 30,
    ingredients: [
      Ingredient(name: "Farinha", quantity: 200, units: "g"),
      Ingredient(name: "Leite", quantity: 500, units: "ml"),
      Ingredient(name: "Ovos", quantity: 2, units: ""),
      Ingredient(name: "Manteiga", quantity: 50, units: "g"),
      Ingredient(name: "Açúcar", quantity: 1, units: "colher de sopa"),
      Ingredient(name: "Sal", quantity: 1, units: "pitada"),
    ],
    steps: [
      "Misture farinha, açúcar e sal numa tigela.",
      "Adicione os ovos e metade do leite e misture bem.",
      "Adicione o restante do leite e misture até ficar homogêneo.",
      "Derreta a manteiga e adicione à massa.",
      "Aqueça uma frigideira e adicione um pouco de manteiga.",
      "Despeje uma concha de massa na frigideira e frite até dourar.",
      "Vire a panqueca e frite o outro lado até dourar.",
      "Repita até usar toda a massa.",
    ],
  ),
  Recipe(
    title: "Esparguete à Bolonhesa",
    portions: 6,
    duration: 45,
    ingredients: [
      Ingredient(name: "Carne moída", quantity: 500, units: "g"),
      Ingredient(name: "Cebola", quantity: 1, units: ""),
      Ingredient(name: "Alho", quantity: 2, units: "dentes"),
      Ingredient(name: "Molho de tomate", quantity: 800, units: "ml"),
      Ingredient(name: "Esparguete", quantity: 400, units: "g"),
      Ingredient(name: "Azeite", quantity: 2, units: "colheres de sopa"),
      Ingredient(name: "Sal", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Pimenta preta", quantity: 1, units: "colher de chá"),
    ],
    steps: [
      "Pique a cebola e o alho.",
      "Aqueça o azeite numa frigideira e refogue a cebola e o alho até dourar.",
      "Adicione a carne moída e cozinhe até dourar.",
      "Despeje o molho de tomate, sal e pimenta. Cozinhe por 20 minutos.",
      "Cozinhe o esparguete conforme as instruções da embalagem.",
      "Sirva o molho bolonhesa sobre o esparguete cozido."
    ],
  ),
  Recipe(
    title: "Frango Assado com Batatas",
    portions: 4,
    duration: 60,
    ingredients: [
      Ingredient(name: "Frango inteiro", quantity: 1, units: ""),
      Ingredient(name: "Batatas", quantity: 800, units: "g"),
      Ingredient(name: "Alho", quantity: 4, units: "dentes"),
      Ingredient(name: "Azeite", quantity: 3, units: "colheres de sopa"),
      Ingredient(name: "Tomilho", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Paprika", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Sal", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Pimenta preta", quantity: 1, units: "colher de chá"),
    ],
    steps: [
      "Preaqueça o forno a 200°C.",
      "Esfregue o frango com sal, pimenta, paprika e tomilho.",
      "Descasque e corte as batatas em pedaços.",
      "Coloque o frango em uma assadeira, distribua as batatas ao redor.",
      "Regue com azeite e asse por aproximadamente 50 minutos ou até dourar.",
      "Verifique se o frango está cozido antes de retirar do forno."
    ],
  ),
  Recipe(
    title: "Salada Caesar",
    portions: 2,
    duration: 15,
    ingredients: [
      Ingredient(name: "Alface romana", quantity: 1, units: ""),
      Ingredient(name: "Frango grelhado", quantity: 200, units: "g"),
      Ingredient(name: "Queijo parmesão", quantity: 50, units: "g"),
      Ingredient(name: "Croutons", quantity: 1, units: "chávena"),
      Ingredient(name: "Molho Caesar", quantity: 3, units: "colheres de sopa"),
      Ingredient(
          name: "Azeite de oliva", quantity: 2, units: "colheres de sopa"),
      Ingredient(name: "Limão", quantity: 1, units: ""),
    ],
    steps: [
      "Lave e rasgue as folhas de alface.",
      "Corte o frango grelhado em tiras.",
      "Rale o queijo parmesão.",
      "Em uma tigela grande, misture o alface, o frango, os croutons e o queijo parmesão.",
      "Prepare o molho Caesar misturando o molho com azeite e suco de limão.",
      "Regue a salada com o molho e misture bem antes de servir."
    ],
  ),
  Recipe(
    title: "Sopa de Legumes",
    portions: 6,
    duration: 45,
    ingredients: [
      Ingredient(name: "Cenouras", quantity: 3, units: ""),
      Ingredient(name: "Batatas", quantity: 2, units: ""),
      Ingredient(name: "Cebolas", quantity: 1, units: ""),
      Ingredient(name: "Alho-poró", quantity: 1, units: ""),
      Ingredient(name: "Caldo de legumes", quantity: 1, units: "litro"),
      Ingredient(name: "Tomates", quantity: 2, units: ""),
      Ingredient(
          name: "Azeite de oliva", quantity: 2, units: "colheres de sopa"),
      Ingredient(name: "Sal", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Pimenta", quantity: 1, units: "pitada"),
    ],
    steps: [
      "Descasque e corte os legumes em pedaços.",
      "Aqueça o azeite em uma panela grande.",
      "Refogue as cebolas e o alho-poró até ficarem macios.",
      "Adicione as cenouras, batatas e tomates.",
      "Despeje o caldo de legumes na panela.",
      "Tempere com sal e pimenta.",
      "Deixe ferver e cozinhe por 30 minutos ou até os legumes estarem macios.",
      "Bata a sopa até obter uma consistência cremosa.",
    ],
  ),
  Recipe(
    title: "Tacos de Frango",
    portions: 4,
    duration: 35,
    ingredients: [
      Ingredient(name: "Peitos de frango", quantity: 500, units: "g"),
      Ingredient(name: "Tortilhas de milho", quantity: 8, units: ""),
      Ingredient(name: "Alface", quantity: 1, units: ""),
      Ingredient(name: "Tomates", quantity: 2, units: ""),
      Ingredient(name: "Queijo cheddar ralado", quantity: 200, units: "g"),
      Ingredient(name: "Creme de leite", quantity: 1, units: "chávena"),
      Ingredient(name: "Cominho em pó", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Pimenta em pó", quantity: 1, units: "colher de chá"),
      Ingredient(
          name: "Coentro picado", quantity: 2, units: "colheres de sopa"),
    ],
    steps: [
      "Tempere os peitos de frango com cominho, pimenta em pó e sal.",
      "Grelhe os peitos de frango até que estejam cozidos por completo.",
      "Corte os peitos de frango em tiras finas.",
      "Aqueça as tortilhas de milho em uma frigideira.",
      "Monte os tacos com alface, tomate, peito de frango, queijo cheddar e creme de leite.",
      "Polvilhe coentro picado por cima e sirva.",
    ],
  ),
  Recipe(
    title: "Bolo de Chocolate",
    portions: 8,
    duration: 60,
    ingredients: [
      Ingredient(name: "Farinha de trigo", quantity: 1, units: "chávena"),
      Ingredient(name: "Açúcar", quantity: 1, units: "chávena"),
      Ingredient(name: "Cacau em pó", quantity: 1, units: "chávena"),
      Ingredient(name: "Fermento em pó", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Ovos", quantity: 2, units: ""),
      Ingredient(name: "Leite", quantity: 1, units: "chávena"),
      Ingredient(name: "Óleo vegetal", quantity: 1, units: "chávena"),
      Ingredient(name: "Baunilha", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Água quente", quantity: 1, units: "chávena"),
      Ingredient(name: "Sal", quantity: 1, units: "colher de chá"),
    ],
    steps: [
      "Pré-aqueça o forno a 180°C e unte uma forma.",
      "Em uma tigela grande, misture farinha, açúcar, cacau, fermento e sal.",
      "Adicione ovos, leite, óleo e baunilha à mistura seca e mexa bem.",
      "Acrescente água quente à massa e misture até ficar homogéneo.",
      "Despeje a massa na forma e leve ao forno por 30-35 minutos.",
      "Deixe esfriar antes de desenformar e decorar a gosto.",
    ],
  ),
  Recipe(
    title: "Cookies de Aveia com Passas",
    portions: 24,
    duration: 20,
    ingredients: [
      Ingredient(name: "Aveia", quantity: 1, units: "chávena"),
      Ingredient(name: "Farinha", quantity: 1, units: "chávena"),
      Ingredient(name: "Açúcar mascavado", quantity: 1, units: "chávena"),
      Ingredient(name: "Manteiga", quantity: 1, units: "chávena"),
      Ingredient(name: "Ovos", quantity: 1, units: ""),
      Ingredient(name: "Passas", quantity: 2, units: "chávena"),
      Ingredient(name: "Baunilha", quantity: 1, units: "colher de chá"),
      Ingredient(
          name: "Bicarbonato de sódio", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Sal", quantity: 1, units: "colher de chá"),
    ],
    steps: [
      "Pré-aqueça o forno a 180°C.",
      "Numa tigela, misture aveia, farinha, bicarbonato e sal.",
      "Em outra tigela, bata a manteiga, açúcar e baunilha até ficar cremoso.",
      "Adicione o ovo à mistura de manteiga e bata bem.",
      "Incorpore gradualmente a mistura de aveia à mistura de manteiga.",
      "Dobre as passas na massa.",
      "Deixe colheradas de massa em tabuleiros e asse por 10-12 minutos.",
      "Deixe esfriar antes de servir.",
    ],
  ),
  Recipe(
    title: "Lasanha de Espinafres",
    portions: 6,
    duration: 60,
    ingredients: [
      Ingredient(name: "Massa de lasanha", quantity: 12, units: "folhas"),
      Ingredient(name: "Espinafres", quantity: 500, units: "g"),
      Ingredient(name: "Queijo ricotta", quantity: 250, units: "g"),
      Ingredient(name: "Queijo parmesão ralado", quantity: 1, units: "chávena"),
      Ingredient(name: "Mozzarella ralada", quantity: 1, units: "chávena"),
      Ingredient(name: "Alho picado", quantity: 2, units: "dentes"),
      Ingredient(
          name: "Azeite de oliva", quantity: 2, units: "colheres de sopa"),
      Ingredient(name: "Molho de tomate", quantity: 2, units: "chávenas"),
      Ingredient(name: "Sal", quantity: 1, units: "pitada"),
      Ingredient(name: "Pimenta preta", quantity: 1, units: "colher de chá"),
      Ingredient(name: "Noz-moscada", quantity: 1, units: "colher de chá"),
    ],
    steps: [
      "Pré-aqueça o forno a 180°C.",
      "Cozinhe as folhas de massa de lasanha de acordo com as instruções da embalagem.",
      "Lave os espinafres e refogue-os em azeite com alho até murchar. Tempere com sal, pimenta e noz-moscada.",
      "Numa tigela, misture os espinafres refogados com o queijo ricotta.",
      "Numa travessa de ir ao forno, espalhe uma camada fina de molho de tomate.",
      "Coloque uma camada de massa de lasanha, seguida da mistura de espinafres e queijos.",
      "Repita as camadas até terminar os ingredientes, terminando com uma camada de queijo mozzarella por cima.",
      "Leve ao forno por cerca de 30 minutos, ou até o queijo ficar dourado e borbulhante.",
      "Deixe repousar por alguns minutos antes de servir.",
    ],
  )
];
