# Lista zadań do optymalizacji [[Uniwersalna struktura projektu dla AI-First Development.md]]

---

## [ ] **1. Likwidacja rozbieżności nazewnictwa w przykładowej strukturze `MANIFEST.md`**

**Zadanie:**  
W sekcji szczegółowego opisu pliku `MANIFEST.md` zmień przykładową strukturę indeksu (obecnie: *Projekt / Architektura / Specyfikacje / API / Workflow / Testy / ADR / Deployment*) tak, aby odzwierciedlała **dokładne, fizyczne i techniczne ścieżki katalogów** zdefiniowane w drzewach `OPTIMAL` i `FULL`.  
Przykłady zmian:  
- „Specyfikacje” → `specs/`  
- „API” → `contracts/`  
- „Workflow” → `ai/workflows/`  
- „ADR” → `decisions/`  
- „Dokumentacja” → `docs/`  

**Dodatkowe wymagania:**  
- `MANIFEST.md` nie może zawierać opisów — wyłącznie listę katalogów i linki.  
- Zakaz używania nazw ogólnych pisanych wielką literą.

**Wyjaśnienie:**  
Aktualny przykład narusza zasadę *Single Source of Truth (SSOT)* oraz regułę „AI nie powinno zgadywać”. MANIFEST musi być precyzyjną mapą fizycznych katalogów.

---

## [ ] **2. Usunięcie podziału na odbiorców (Człowiek vs AI) i ujednolicenie dostępu do kontekstu**

**Zadanie:**  
Usuń z dokumentu wszystkie sugestie, że katalogi są „dla ludzi” lub „dla AI”.  
W sekcji *Filozofia* dodaj nadrzędną zasadę:  
**„Repozytorium posiada jedną, całkowicie wspólną strukturę dla człowieka oraz agentów AI. Obie strony korzystają z tych samych katalogów i plików.”**

**Dodatkowe wymagania:**  
- Dopisać: „Każdy plik jest równorzędnym źródłem informacji dla człowieka i AI — nie istnieją katalogi ‘dla ludzi’ ani ‘dla AI’.”

**Wyjaśnienie:**  
Izolowanie kontekstu blokuje AI możliwość analizy środowiska, a ludziom utrudnia kontrolę nad instrukcjami.

---

## [ ] **3. Wprowadzenie rygorystycznej zasady SSOT dla relacji `ai/context/` oraz `docs/**`**

**Zadanie:**  
W opisie katalogu `ai/context/` wprowadź bezwzględny zakaz powielania lub streszczania opisów technicznych znajdujących się w `docs/`, `config/`, `decisions/`.  
Pliki w `ai/context/` mają pełnić funkcję *punktów wejścia* zawierających:  
- cele wysokiego poziomu,  
- linki Markdown do właściwych plików,  
- zero diagramów technicznych.

**Wyjaśnienie:**  
Streszczenia dla AI prowadzą do rozjechania się wiedzy i halucynacji.

---

## [ ] **4. Unifikacja procesów poprzez scalenie katalogów `playbooks/` oraz `ai/workflows/**`**

**Zadanie:**  
Usuń katalog `playbooks/` z wersji FULL oraz z opisów.  
Wszystkie procedury operacyjne przenieś do `ai/workflows/`.  
W opisie `ai/workflows/` dopisz, że katalog zawiera **uniwersalne procedury krok po kroku wykonywane przez ludzi i AI**.

**Dodatkowe wymagania:**  
- Workflowy muszą być atomowe i deterministyczne.  
- Playbooki nie mogą istnieć jako osobna kategoria.

**Wyjaśnienie:**  
Podział generuje duplikację procedur i chaos.

---

## [ ] **5. Rozgraniczenie ról i definicja odpowiedzialności dla plików zadań (`TODO.md`, `plans/`, `ai/memory/`)**

**Zadanie:**  
Wprowadź sztywne reguły:  
1. `TODO.md` — jedyne miejsce na aktywną kolejkę zadań.  
2. `plans/` — wyłącznie epiki i duże zmiany, linkowane z `TODO.md`.  
3. `ai/memory/` — wyłącznie wiedza historyczna, zakaz list zadań.

**Dodatkowe wymagania:**  
- `TODO.md` nie może zawierać zadań technicznych typu „naprawić bug”.  
- `ai/memory/` nie może zawierać aktualnych problemów ani TODO.

**Wyjaśnienie:**  
Bez tej separacji AI rozprasza zadania po wielu plikach.

---

## [ ] **6. Zawężenie kompetencji katalogu `ai/prompts/**`**

**Zadanie:**  
Dodać zastrzeżenie, że katalog `ai/prompts/` służy wyłącznie do przechowywania **generycznych, ręcznie wywoływanych promptów użytkownika**.  
Zakaz umieszczania tam instrukcji systemowych.

**Dodatkowe wymagania:**  
- Pliki w `ai/prompts/` nie mogą zawierać reguł typu „always”, „never”, „must”.  
- Instrukcje systemowe należą do `ai/rules/` lub `ai/workflows/`.

**Wyjaśnienie:**  
Mieszanie promptów użytkownika z regułami systemowymi prowadzi do błędów zachowania agentów.

---

## [ ] **7. Zabezpieczenie katalogu `tmp/` w konfiguracji systemu kontroli wersji**

**Zadanie:**  
W opisie `tmp/` dodać nakaz ignorowania katalogu w `.gitignore`, wraz z ukrytymi logami narzędzi AI (np. `.cursor-tutor`).

**Dodatkowe wymagania:**  
- `tmp/` musi być ignorowany również przez CI/CD.

**Wyjaśnienie:**  
AI generuje pliki tymczasowe, które nie mogą trafiać do repozytorium.

---

## [ ] **8. Utrzymanie uniwersalności integracji z klientami AI**

**Zadanie:**  
Usunąć dedykowane instrukcje dla Cursor, Windsurf, Roo, Claude Code itd.  
Dodać zasadę:  
**„Pliki konfiguracyjne klientów AI powinny zawierać maksymalnie 2–3 linie odsyłające model bezpośrednio do `AGENTS.md`.”**

**Dodatkowe wymagania:**  
- Pliki konfiguracyjne nie mogą zawierać przykładów kodu.

**Wyjaśnienie:**  
Repozytorium musi być niezależne od IDE.

---

## [ ] **9. Korekta logiczna kierunku przepływu na schemacie Mermaid**

**Zadanie:**  
W sekcji „Integracja z klientami AI” odwrócić relację tak, aby przepływ wskazywał:  
`AGENTS.md` → `ai/context/` → `specs/` → `docs/`.

**Wyjaśnienie:**  
Specyfikacja biznesowa definiuje *co*, dokumentacja techniczna opisuje *jak*.

---

## [ ] **10. Wprowadzenie ścisłej granicy kompetencji pomiędzy `specs/` a `contracts/**`**

**Zadanie:**  
Dodać zasadę:  
- `specs/` opisuje wymagania biznesowe i kryteria akceptacji,  
- `contracts/` zawiera formalne schematy API i struktur danych,  
- `specs/` odwołuje się linkami do `contracts/`, bez powielania pól.

**Dodatkowe wymagania:**  
- Pliki w `specs/` nie mogą zawierać tabel danych ani definicji pól.

**Wyjaśnienie:**  
Dublowanie struktur danych prowadzi do błędów generowanych przez AI.

---

## [ ] **11. Warunkowe zarządzanie terminologią na poziomach MINIMAL i OPTIMAL**

**Zadanie:**  
Dodać adnotację:  
- w MINIMAL i OPTIMAL glossary.md może przechowywać kluczowe terminy biznesowe,  
- w FULL cała wiedza biznesowa migruje do `knowledge/terminology.md`,  
- glossary.md zawiera wyłącznie terminy techniczne.

**Dodatkowe wymagania:**  
- glossary.md musi zawierać definicje jednozdaniowe.

**Wyjaśnienie:**  
Zapobiega chaosowi nazewnictwa w mniejszych projektach.

---

## [ ] **12. Zarządzanie plikami konfiguracyjnymi a wymagania mechanizmu Auto-Discovery**

**Zadanie:**  
Dodać uwagę:  
**„Katalog `config/` jest centralnym repozytorium konfiguracji. Jeśli tooling wymaga pliku w root, należy umieścić tam minimalny plik rozszerzający konfigurację z `config/` lub użyć symlinka.”**

**Dodatkowe wymagania:**  
- Pliki konfiguracyjne w root muszą być minimalne (maks. 5 linii).

**Wyjaśnienie:**  
Zapewnia czystość struktury bez psucia automatyzacji.

---

Oto **poprawiona wersja TYLKO wskazanych punktów (13–20)** — w **identycznym stylu**, strukturze i tonie jak wcześniejsze zadania z pliku `task-zmiany.md`.  
Zachowałem format:

- checkbox  
- pogrubiony tytuł  
- sekcja **Zadanie:**  
- sekcja **Wyjaśnienie:**  

Tak jak w oryginale.

---

# 🆕 DODATKOWE ZADANIA (z moich analiz) — *wersja dopasowana stylistycznie*

---

## [ ] **13. Zero wiedzy w `AGENTS.md`**

**Zadanie:**  
W opisie pliku `AGENTS.md` dopisz jednoznaczną zasadę, że dokument ten nie może zawierać żadnych opisów architektury, technologii, decyzji projektowych ani streszczeń. `AGENTS.md` pełni wyłącznie rolę punktu wejścia i ma zawierać jedynie odnośniki do właściwych źródeł wiedzy.

**Wyjaśnienie:**  
AI ma tendencję do dopisywania wiedzy do pliku wejściowego, co łamie SSOT i prowadzi do nadpisywania kontekstu.

---

## [ ] **14. Zero kodu w dokumentacji technicznej**

**Zadanie:**  
W sekcji opisującej katalog `docs/` dopisz zasadę, że dokumentacja nie może zawierać fragmentów kodu dłuższych niż 5 linii. Dłuższe przykłady powinny znajdować się wyłącznie w `examples/` lub w kodzie źródłowym.

**Wyjaśnienie:**  
AI często traktuje duże fragmenty kodu w dokumentacji jako nadrzędne źródło prawdy, co prowadzi do błędów implementacyjnych.

---

## [ ] **15. Zero zadań w `specs/`**

**Zadanie:**  
Usuń z katalogu `specs/` wszelkie pliki typu `tasks.md` oraz dopisz zasadę, że katalog ten nie może zawierać żadnych list zadań. Zadania muszą znajdować się wyłącznie w `TODO.md`, a `specs/` ma opisywać wyłącznie wymagania biznesowe i kryteria akceptacji.

**Wyjaśnienie:**  
Mieszanie wymagań biznesowych z zadaniami prowadzi do chaosu i rozproszenia backlogu.

---

## [ ] **16. Zero workflowów w `ai/rules/`**

**Zadanie:**  
Doprecyzować opis katalogu `ai/rules/`, dodając zasadę, że pliki w tym katalogu mogą zawierać wyłącznie reguły i konwencje, a nie kroki proceduralne. Procedury krok po kroku należą wyłącznie do `ai/workflows/`.

**Wyjaśnienie:**  
AI często miesza reguły z instrukcjami operacyjnymi, co prowadzi do nieprzewidywalnego zachowania agentów.

---

## [ ] **17. Zero pamięci operacyjnej w `ai/memory/`**

**Zadanie:**  
Dodać zasadę, że katalog `ai/memory/` służy wyłącznie do przechowywania wiedzy historycznej (np. znane problemy, dług techniczny, lessons learned). Zakaz umieszczania tam aktualnych zadań, planów lub bieżących problemów.

**Wyjaśnienie:**  
AI ma tendencję do traktowania `ai/memory/` jako aktywnego backlogu, co prowadzi do rozproszenia zadań.

---

## [ ] **18. Zero aliasów katalogów**

**Zadanie:**  
Dodać ogólną zasadę, że każdy katalog w repozytorium musi posiadać jedną, oficjalną nazwę. Zakaz tworzenia aliasów, skrótów lub alternatywnych nazw katalogów w dokumentacji lub przykładach.

**Wyjaśnienie:**  
Aliasowanie katalogów prowadzi do niejednoznaczności i błędów w nawigacji kontekstu przez AI.

---

## [ ] **19. Zero skrótów nazw katalogów**

**Zadanie:**  
Dodać zasadę, że nazwy katalogów muszą być pełne i jednoznaczne (np. `config/` zamiast `cfg/`, `infrastructure/` zamiast `infra/`). Skróty są zabronione.

**Wyjaśnienie:**  
Skrócone nazwy katalogów są trudniejsze do przewidzenia dla AI i zwiększają ryzyko halucynacji.

---

## [ ] **20. Zero plików `.md` w `src/`**

**Zadanie:**  
Dodać zasadę, że katalog `src/` może zawierać wyłącznie kod źródłowy. Pliki dokumentacyjne (`.md`) są zabronione i muszą znajdować się w `docs/`, `knowledge/` lub `ai/context/`.

**Wyjaśnienie:**  
Obecność dokumentacji w `src/` zaburza separację odpowiedzialności i prowadzi do błędów w analizie kodu przez AI.

---
