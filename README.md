# feriados_pt

Feriados nacionais portugueses para Dart e Flutter.

Calcula os feriados obrigatórios para qualquer ano, incluindo os feriados móveis baseados na Páscoa, com tratamento correto do período de supressão de 2013–2015.

## Instalação

```yaml
dependencies:
  feriados_pt: ^0.1.0
```

## Utilização

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

// Contar dias úteis excluindo feriados e fins de semana
bool isWorkingDay(DateTime d) =>
    d.weekday != DateTime.saturday &&
    d.weekday != DateTime.sunday &&
    !isHoliday(d);
```

## Feriados incluídos

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

### `List<Holiday> getHolidays(int year)`

Devolve todos os feriados nacionais obrigatórios para o `year` indicado, ordenados por data.

### `bool isHoliday(DateTime date)`

Devolve `true` se `date` for um feriado nacional. A componente de hora é ignorada.

### `Holiday? holidayAt(DateTime date)`

Devolve o `Holiday` correspondente a `date`, ou `null` se não for feriado.

### Classe `Holiday`

| Propriedade | Tipo | Descrição |
|------------|------|-----------|
| `date` | `DateTime` | Data do feriado (meia-noite) |
| `name` | `String` | Nome oficial em português |
| `kind` | `HolidayKind` | `fixed` ou `moveable` |

## Licença

MIT
