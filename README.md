# feriados_pt

Feriados portugueses para Dart e Flutter — nacionais, municipais e regionais.

Os feriados nacionais são calculados localmente (offline). Os feriados municipais e regionais são obtidos através da API da SAPO.

## Instalação

```yaml
dependencies:
  feriados_pt: ^0.2.1
```

## Utilização

### Feriados nacionais (offline)

```dart
import 'package:feriados_pt/feriados_pt.dart';

// Todos os feriados de um ano
final holidays = getHolidays(2026);
for (final h in holidays) {
  print('${h.date.toIso8601String().substring(0, 10)}  ${h.name}');
}

// Verificar se uma data é feriado
isHoliday(DateTime(2026, 4, 25)); // true

// Obter o feriado de uma data
final h = holidayAt(DateTime(2026, 4, 25));
print(h?.name); // Dia da Liberdade

// Dias úteis excluindo feriados e fins de semana
bool isWorkingDay(DateTime d) =>
    d.weekday != DateTime.saturday &&
    d.weekday != DateTime.sunday &&
    !isHoliday(d);
```

### Feriados municipais e regionais (via API SAPO)

```dart
// Feriados de um município pelo enum
final local = await getHolidaysByMunicipality(2026, Municipio.lisboa);

// Lookup por nome (tolerante a maiúsculas e acentos)
final local = await getHolidaysByMunicipality(2026, Municipio.find('braga'));

// Incluir também os feriados nacionais
final todos = await getHolidaysByMunicipality(
  2026,
  Municipio.porto,
  includeNational: true,
);

// Todos os municipais de Portugal
final municipais = await getMunicipalHolidays(2026);

// Feriados regionais (Açores e Madeira)
final regionais = await getRegionalHolidays(2026);
```

## Feriados nacionais incluídos

| Data | Feriado | Tipo |
|------|---------|------|
| 1 Jan | Ano Novo | Fixo |
| Variável | Sexta-feira Santa | Móvel |
| Variável | Domingo de Páscoa | Móvel |
| 25 Abr | Dia da Liberdade | Fixo |
| 1 Mai | Dia do Trabalhador | Fixo |
| 10 Jun | Dia de Portugal | Fixo |
| Variável | Corpo de Deus (+60 dias após Páscoa) | Móvel |
| 15 Ago | Assunção de Nossa Senhora | Fixo |
| 5 Out | Implantação da República | Fixo |
| 1 Nov | Dia de Todos os Santos | Fixo |
| 1 Dez | Restauração da Independência | Fixo |
| 8 Dez | Imaculada Conceição | Fixo |
| 25 Dez | Natal | Fixo |

> **Nota histórica:** Entre 2013 e 2015 (Lei 23/2012) foram suprimidos quatro feriados — *Corpo de Deus*, *Dia de Todos os Santos*, *Restauração da Independência* e *Imaculada Conceição*. Foram repostos em 2016 (Lei 8/2016). O package reflete este histórico automaticamente.

## API

### Feriados nacionais

#### `List<Holiday> getHolidays(int year)`
Devolve todos os feriados nacionais obrigatórios para o `year` indicado, ordenados por data.

#### `bool isHoliday(DateTime date)`
Devolve `true` se `date` for um feriado nacional. A componente de hora é ignorada.

#### `Holiday? holidayAt(DateTime date)`
Devolve o `Holiday` correspondente a `date`, ou `null` se não for feriado.

### Feriados municipais e regionais

#### `Future<List<Holiday>> getHolidaysByMunicipality(int year, Municipio municipio, {bool includeNational})`
Devolve os feriados do município indicado para o `year`. Use `includeNational: true` para incluir também os nacionais.

#### `Future<List<Holiday>> getMunicipalHolidays(int year)`
Devolve todos os feriados municipais de Portugal para o `year`.

#### `Future<List<Holiday>> getRegionalHolidays(int year)`
Devolve os feriados regionais (Açores e Madeira) para o `year`.

### Classe `Holiday`

| Propriedade | Tipo | Descrição |
|------------|------|-----------|
| `date` | `DateTime` | Data do feriado (meia-noite) |
| `name` | `String` | Nome oficial em português |
| `kind` | `HolidayKind` | `fixed` ou `moveable` |
| `scope` | `HolidayScope` | `national`, `regional` ou `municipal` |
| `description` | `String?` | Descrição opcional (proveniente da API SAPO) |

### Enum `Municipio`

Enum com todos os municípios portugueses suportados pela API SAPO, com `id` e `nome`.

```dart
Municipio.lisboa.id;    // '1106'
Municipio.lisboa.nome;  // 'Lisboa'

// Lookup por nome
Municipio.find('viana do castelo'); // Municipio.vianaDoCastelo
```

Para municípios homónimos usa o nome completo: `Municipio.lagoaAlgarve` / `Municipio.lagoaAcores`, `Municipio.calhetaMadeira` / `Municipio.calhetaAcores`.

## Licença

MIT
