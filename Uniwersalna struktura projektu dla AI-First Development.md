# Uniwersalna struktura projektu dla AI-First Development

> **Cel:** stworzenie uniwersalnej struktury projektu, która działa niezależnie od języka programowania i frameworka, zgodnie z najlepszymi praktykami rozwoju oprogramowania. Działająca dobrze z klientami AI (Claude Code, Cursor, OpenCode, Cline, Roo Code, Codex CLI, Gemini CLI, Windsurf, Antigravity i innymi), tak aby można z nich było korzystać równocześnie lub zmieniać je w przyszłości bez konieczności przebudowy repozytorium.

---

## Filozofia

Nowoczesne repozytorium nie jest już projektowane wyłącznie dla programisty.

Jest projektowane dla:
- Programisty
- AI Assistant
- AI Agent
- Code Review Agent
- DevOps Agent
- Test Agent
- Dokumentacji

Największym ograniczeniem współczesnych modeli LLM nie jest generowanie kodu, ale **zarządzanie kontekstem (Context Management)**.

**Nadrzędna zasada dostępu do kontekstu:**
Repozytorium posiada jedną, całkowicie wspólną strukturę dla człowieka oraz agentów AI. Obie strony korzystają z tych samych katalogów i plików. Każdy plik jest równorzędnym źródłem informacji dla człowieka i AI — nie istnieją katalogi „dla ludzi" ani „dla AI".

Dlatego dobra struktura projektu powinna:
- minimalizować zgadywanie przez AI,
- być przewidywalna,
- mieć jedną lokalizację dla każdej informacji,
- rozdzielać wiedzę od implementacji,
- umożliwiać łatwą zmianę klienta AI bez przebudowy repozytorium.

**Zasady nazewnictwa katalogów:**
- Każdy katalog w repozytorium musi posiadać jedną, oficjalną nazwę. Zakaz tworzenia aliasów, skrótów lub alternatywnych nazw katalogów w dokumentacji lub przykładach.
- Nazwy katalogów muszą być pełne i jednoznaczne (np. `config/` zamiast `cfg/`, `infrastructure/` zamiast `infra/`). Skróty są zabronione.

---

## Najważniejsze zasady

### 1. Single Source of Truth (SSOT)

Każda informacja występuje tylko w jednym miejscu.

Źle:

```txt
├── README
├── CLAUDE.md
├── .cursor/rules
├── AGENTS.md
└── docs/
```

wszędzie opis architektury.

Dobrze:

```txt
├── docs/
└── ai/
```

a wszystkie pozostałe pliki jedynie odwołują się do tych źródeł.

---

### 2. AI nie powinno zgadywać

Jeżeli projekt posiada:
- konwencje nazewnictwa,
- architekturę,
- decyzje projektowe,
- workflow,

to powinny być zapisane.

---

### 3. Małe pliki

AI dużo lepiej analizuje:
- pliki 100–300 linii,
- jedną odpowiedzialność na plik,
- małe katalogi.

---

### 4. Dokumentacja blisko kodu

Kod opisuje implementację.

Dokumentacja opisuje:
- dlaczego,
- kiedy,
- jak.

---

### 5. Repozytorium ma być niezależne od IDE

Nie chcemy przepisywać dokumentacji przy zmianie narzędzia AI. Pliki konfiguracyjne klientów AI powinny zawierać maksymalnie 2–3 linie odsyłające model bezpośrednio do `AGENTS.md`. Pliki konfiguracyjne nie mogą zawierać przykładów kodu ani opisów architektury.

---

## Wersja MINIMAL (podstawowa)

```txt
project/
├── AGENTS.md
├── README.md
├── ai/
│   ├── context/
│   └── rules/
├── docs/
├── src/
└── tests/
```

---

## Wersja OPTIMAL (zalecana)

```txt
project/
├── AGENTS.md
├── MANIFEST.md
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── TODO.md
├── LICENSE
├── ai/
│   ├── context/
│   ├── rules/
│   ├── workflows/
│   ├── prompts/
│   ├── templates/
│   └── memory/
├── specs/
├── docs/
├── decisions/
├── contracts/
├── src/
├── tests/
├── config/
├── scripts/
├── infrastructure/
├── tools/
├── examples/
├── assets/
├── .github/
├── .gitignore
└── tmp/
```

---

## Wersja FULL (AI Native)

```txt
project/
├── AGENTS.md
├── MANIFEST.md
├── README.md
├── CHANGELOG.md
├── ROADMAP.md
├── TODO.md
├── LICENSE
├── ai/
│   ├── context/
│   ├── rules/
│   ├── workflows/
│   ├── prompts/
│   ├── templates/
│   └── memory/
├── specs/
├── knowledge/
├── checklists/
├── decisions/
├── contracts/
├── docs/
├── src/
├── tests/
├── infrastructure/
├── config/
├── scripts/
├── tools/
├── examples/
├── plans/
├── experiments/
├── archive/
├── assets/
├── .github/
├── .gitignore
└── tmp/
```

---

## Szczegółowy opis katalogów

---

## AGENTS.md ⭐⭐⭐⭐⭐

Najważniejszy plik dla agentów AI.

**Pełni wyłącznie rolę punktu wejścia (Entry Point).** Nie może zawierać żadnych opisów architektury, technologii, decyzji projektowych ani streszczeń. Umieszczanie wiedzy w pliku wejściowym łamie SSOT i prowadzi do nadpisywania kontekstu.

Powinien zawierać jedynie:
- gdzie znajduje się dokumentacja,
- jakie reguły obowiązują,
- jakie workflow stosować,
- czego nie robić.

Przykład:

```txt
Read first:
├── ai/context/project.md
├── ai/context/architecture.md

Follow:
├── ai/rules/coding.md

Use workflows:
├── ai/workflows/new-feature.md
```

Nigdy nie duplikujemy wiedzy.

---

## MANIFEST.md ⭐⭐⭐⭐⭐

Mapa całego repozytorium. To indeks projektu.

`MANIFEST.md` zawiera wyłącznie listę katalogów i linki do właściwych plików — bez opisów. Zakaz używania nazw ogólnych pisanych wielką literą.

Przykład:

```txt
├── [ai/context/](ai/context/)
├── [specs/](specs/)
├── [contracts/](contracts/)
├── [ai/workflows/](ai/workflows/)
├── [tests/](tests/)
├── [decisions/](decisions/)
├── [docs/](docs/)
```

Dzięki temu AI nie musi przeszukiwać całego repozytorium.

---

## ai/

Katalog zawierający instrukcje sterujące zachowaniem agentów AI (reguły, przepływy pracy, prompty, szablony). Struktura jest wspólna dla człowieka i AI — programiści powinni tu zaglądać, aby konfigurować zachowanie asystentów lub zapoznać się z regułami.

---

## ai/context/

Opis projektu.

```txt
├── project.md
├── architecture.md
├── modules.md
├── stack.md
└── glossary.md
```

Zawiera:
- cel projektu,
- moduły,
- architekturę,
- technologie,
- słownik pojęć.

**Zasada SSOT:** Pliki w `ai/context/` pełnią funkcję *punktów wejścia* i mogą zawierać wyłącznie:
- cele wysokiego poziomu,
- linki Markdown do właściwych plików w `docs/`, `config/`, `decisions/`.

Bezwzględny zakaz powielania lub streszczania opisów technicznych znajdujących się w `docs/`, `config/`, `decisions/`. Zero diagramów technicznych — te należą do `docs/`.

---

## ai/rules/

Reguły i konwencje obowiązujące AI.

Pliki w tym katalogu mogą zawierać wyłącznie reguły i konwencje, a **nie** kroki proceduralne. Procedury krok po kroku należą wyłącznie do `ai/workflows/`.

Przykłady:

```txt
├── coding.md
├── testing.md
├── git.md
├── security.md
└── review.md
```

Przykład zawartości:

```txt
Maximum file 300 lines

Maximum function 40 lines

Use Composition

No Business Logic in Controllers
```

---

## ai/workflows/

Procedury operacyjne zawierające **uniwersalne procedury krok po kroku wykonywane przez ludzi i AI**. Workflowy muszą być atomowe i deterministyczne.

Przykład:

```txt
├── new-feature.md
├── bugfix.md
├── refactor.md
├── release.md
├── rollback.md
├── incident.md
├── production-hotfix.md
└── onboarding.md
```

---

## ai/prompts/

Gotowe, **generyczne prompty ręcznie wywoływane przez użytkownika**. Katalog służy wyłącznie do przechowywania takich promptów.

**Zasady:**
- Pliki w `ai/prompts/` nie mogą zawierać reguł typu „always", „never", „must".
- Instrukcje systemowe należą do `ai/rules/` lub `ai/workflows/` — nie do `ai/prompts/`.

```txt
├── create-api.md
├── review.md
├── debug.md
└── migration.md
```

---

## ai/templates/

Szablony.

```txt
├── service
├── controller
├── repository
├── migration
├── component
└── endpoint
```

---

## ai/memory/

Pamięć historyczna projektu. Służy wyłącznie do przechowywania wiedzy historycznej.

```txt
├── known-problems.md
├── technical-debt.md
└── lessons-learned.md
```

**Zasada:** Katalog `ai/memory/` przechowuje wyłącznie wiedzę historyczną (np. znane problemy, dług techniczny, lessons learned). Zakaz umieszczania tam aktualnych zadań, planów lub bieżących problemów. Aktywna kolejka zadań należy wyłącznie do `TODO.md`.

---

## specs/

Najważniejszy katalog biznesowy. Opisuje **wymagania biznesowe i kryteria akceptacji**.

Nie implementację.

Przykład:

```txt
└── authentication/
    ├── requirements.md
    ├── acceptance.md
    └── api.md
```

**Zasady:**
- Katalog `specs/` nie może zawierać żadnych list zadań. Zadania muszą znajdować się wyłącznie w `TODO.md`.
- Pliki w `specs/` nie mogą zawierać tabel danych ani definicji pól — te należą do `contracts/`.
- `specs/` odwołuje się linkami do `contracts/`, bez powielania pól.

AI znacznie lepiej implementuje funkcjonalność posiadając specyfikację.

---

## knowledge/

Wiedza domenowa.

```txt
├── business.md
├── faq.md
├── terminology.md
├── edge-cases.md
└── legal.md
```

Wiedza domenowa i biznesowa, nie techniczna (ta znajduje się w `docs/`).

**Zasada SSOT:** `knowledge/terminology.md` stanowi nadrzędne źródło pojęć domenowych (biznesowych). W wersji FULL cała wiedza biznesowa migruje do `knowledge/terminology.md`. Plik `ai/context/glossary.md` powinien jedynie odwoływać się do niego lub definiować pojęcia czysto techniczne/programistyczne (np. specyficzne nazwy zmiennych czy modułów), unikając duplikowania wiedzy biznesowej.

---

## checklists/

Checklisty weryfikujące poprawność wykonania poszczególnych zadań.

```txt
├── review.md
├── release.md
├── security.md
└── testing.md
```

Checklisty określają zwięzłe kryteria weryfikacyjne (np. co sprawdzić przed wydaniem wersji), podczas gdy pełne procedury krok po kroku znajdują się w `ai/workflows/`. AI doskonale sprawdza się w automatycznej weryfikacji takich checklist.

---

## decisions/

Architecture Decision Records (ADR).

Przykład:

```txt
├── 001-postgres.md
├── 002-events.md
└── 003-auth.md
```

Opisujemy:

- decyzję,
- uzasadnienie,
- alternatywy,
- konsekwencje.

AI nie zgaduje dlaczego coś zostało wybrane.

---

## contracts/

Formalne schematy API i struktur danych.

```txt
├── OpenAPI
├── JSON Schema
├── GraphQL
├── Events
├── gRPC
└── Proto
```

**Zasada:** `contracts/` zawiera formalne schematy API i struktur danych. `specs/` opisuje wymagania biznesowe i kryteria akceptacji, odwołując się linkami do `contracts/` bez powielania pól.

AI nie zgaduje struktur danych.

---

## docs/

Dokumentacja techniczna, systemowa i architektoniczna projektu. Jest przeznaczona do czytania przez programistów i AI w celu zrozumienia kontekstu technicznego systemu.

Przykład:

```txt
├── architecture/
├── database/
├── deployment/
├── api/
├── security/
└── testing/
```

**Zasada:** Dokumentacja nie może zawierać fragmentów kodu dłuższych niż 5 linii. Dłuższe przykłady powinny znajdować się wyłącznie w `examples/` lub w kodzie źródłowym.

---

## src/

Kod aplikacji. Katalog `src/` może zawierać wyłącznie kod źródłowy. Pliki dokumentacyjne (`.md`) są zabronione i muszą znajdować się w `docs/`, `knowledge/` lub `ai/context/`.

---

## tests/

Testy.

Najlepiej podzielone analogicznie do src.

---

## config/

Cała konfiguracja projektu. Katalog `config/` jest centralnym repozytorium konfiguracji. Jeśli tooling wymaga pliku w root, należy umieścić tam minimalny plik (maks. 5 linii) rozszerzający konfigurację z `config/` lub użyć symlinka.

```txt
├── eslint
├── prettier
├── tsconfig
├── vite
├── webpack
├── nginx
└── docker
```

---

## scripts/

Automatyzacja.

```txt
├── build
├── release
├── backup
├── seed
├── lint
├── generate
└── migration
```

---

## infrastructure/

DevOps.

```txt
├── Docker
├── Terraform
├── Helm
├── Kubernetes
└── Ansible
```

---

## tools/

Narzędzia pomocnicze.

```txt
├── generator
├── cli
├── parser
└── converter
```

---

## examples/

Przykłady użycia i dłuższe fragmenty kodu (powyżej 5 linii), do których odwołuje się dokumentacja.

```txt
├── request.json
├── response.json
├── webhook.json
└── event.json
```

LLM bardzo dobrze uczy się przez przykłady (Few-Shot Learning).

---

## plans/

Plany większych zmian (epiki i duże zmiany), linkowane z `TODO.md`.

```txt
├── migration.md
├── refactor.md
└── caching.md
```

---

## experiments/

Eksperymenty.

```txt
├── RAG
├── LLM
├── Prototype
└── Benchmark
```

Nie mieszamy ich z produkcją.

---

## archive/

Kod historyczny.

```txt
├── legacy/
├── deprecated/
└── old-docs/
```

Pozwala AI odróżnić kod aktywny od starego.

---

## assets/

Pliki statyczne.

```txt
├── images
├── icons
├── fonts
└── pdf
```

---

## tmp/

Pliki tymczasowe. AI często generuje tymczasowe pliki — nie powinny trafiać do `src/`.

**Zasada:** Katalog `tmp/` musi być ignorowany w `.gitignore` (wraz z ukrytymi logami narzędzi AI, np. `.cursor-tutor`) oraz przez CI/CD.

---

## README.md

Krótki.

Powinien zawierać:
- opis projektu,
- instalację,
- uruchomienie,
- strukturę,
- link do dokumentacji.

Nie powinien zastępować dokumentacji.

---

## CHANGELOG.md

Historia zmian.

---

## ROADMAP.md

Plan rozwoju.

---

## TODO.md

Jedyne miejsce na aktywną kolejkę zadań.

**Zasady:**
- `TODO.md` — jedyne miejsce na aktywną kolejkę zadań.
- `plans/` — wyłącznie epiki i duże zmiany, linkowane z `TODO.md`.
- `ai/memory/` — wyłącznie wiedza historyczna, zakaz list zadań.
- `TODO.md` nie może zawierać zadań technicznych typu „naprawić bug" — te należą do systemu ticketów lub `plans/`.

---

## Zarządzanie terminologią wg poziomu projektu

- **MINIMAL i OPTIMAL:** `ai/context/glossary.md` może przechowywać kluczowe terminy biznesowe i techniczne.
- **FULL:** Cała wiedza biznesowa migruje do `knowledge/terminology.md`. `ai/context/glossary.md` zawiera wyłącznie terminy techniczne.
- We wszystkich poziomach: `ai/context/glossary.md` musi zawierać definicje jednozdaniowe.

---

## Integracja z klientami AI

Pliki konfiguracyjne klientów AI powinny zawierać **maksymalnie 2–3 linie** odsyłające model bezpośrednio do `AGENTS.md`. Pliki konfiguracyjne nie mogą zawierać przykładów kodu ani wiedzy biznesowej.

Przykłady plików konfiguracyjnych:

```txt
├── AGENTS.md
├── CLAUDE.md
├── .cursor/
├── .clinerules
├── .roo/
├── .windsurf/
└── .github/copilot-instructions.md
```

**Zasada:**
- Żaden z tych plików nie powinien zawierać wiedzy biznesowej ani architektonicznej.
- Powinny jedynie wskazywać lokalizację dokumentacji (max. 2–3 linie).

Przepływ informacji:

```mermaid
flowchart TD
    CLAUDE[CLAUDE.md]
    AGENTS[AGENTS.md]
    CONTEXT[ai/context/]
    SPECS[specs/]
    DOCS[docs/]

    CLAUDE -->|Read AGENTS.md| AGENTS
    AGENTS --> CONTEXT
    CONTEXT --> SPECS
    SPECS --> DOCS
```

Dzięki temu zmiana IDE nie wymaga przepisywania dokumentacji.

---
`

## Dobre praktyki dla AI

| Zasada | Korzyść |
|----------|----------|
| Jedna odpowiedzialność na plik | Łatwiejsza analiza przez AI |
| Krótkie pliki (100–300 linii) | Mniejsze zużycie kontekstu |
| Przewidywalne nazwy | AI szybciej odnajduje informacje |
| Dokumentacja blisko kodu | Łatwiejsze zrozumienie projektu |
| ADR (`decisions/`) | AI rozumie decyzje architektoniczne |
| `specs/` | AI implementuje wymagania zamiast zgadywać |
| `contracts/` | Brak domysłów dotyczących struktur danych |
| `examples/` | Few-Shot Learning poprawia jakość odpowiedzi |
| `checklists/` | Powtarzalne procesy i mniej błędów |
| `ai/workflows/` | Gotowe procedury operacyjne dla ludzi i AI |
| `ai/rules/` | Spójność kodu między sesjami |
| `ai/memory/` | Zachowanie wiedzy historycznej o projekcie |
| `MANIFEST.md` | AI szybko odnajduje właściwe pliki |
| `AGENTS.md` | Jeden punkt wejścia dla wszystkich agentów |

---

## Podsumowanie

Nowoczesne repozytorium **AI-First** powinno rozdzielać odpowiedzialności na cztery główne obszary:

| Obszar | Przeznaczenie |
|----------|----------------|
| **Kod (`src/`)** | Implementacja aplikacji |
| **Dokumentacja (`docs/`, `knowledge/`, `specs/`)** | Wiedza i opis wymagań biznesowych |
| **Kontekst AI (`ai/`)** | Reguły, workflow, pamięć historyczna, szablony i prompty |
| **Integracja z narzędziami AI (`AGENTS.md`, `CLAUDE.md`, `.cursor/`, `.github/copilot-instructions.md` itd.)** | Cienka warstwa (max. 2–3 linie) wskazująca, gdzie znajduje się właściwy kontekst, bez duplikowania wiedzy |

Tak zaprojektowana struktura:
- jest niezależna od języka programowania i frameworka,
- działa z większością współczesnych klientów AI,
- ułatwia zmianę narzędzia bez migracji dokumentacji,
- minimalizuje błędy wynikające z utraty kontekstu,
- zapewnia spójność pracy ludzi i agentów AI,
- skaluje się od małych aplikacji po duże systemy wielomodułowe.
