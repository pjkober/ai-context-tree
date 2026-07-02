## 📋 Lista zadań do optymalizacji [[Uniwersalna struktura projektu dla AI-First Development.md]]

* [ ] **1. Likwidacja rozbieżności nazewnictwa w przykładowej strukturze `MANIFEST.md**`
* **Zadanie:** W sekcji szczegółowego opisu pliku `MANIFEST.md` zmień przykładową strukturę indeksu (obecnie: *Projekt / Architektura / Specyfikacje / API / Workflow / Testy / ADR / Deployment*) tak, aby odzwierciedlała dokładne, fizyczne i techniczne ścieżki oraz nazwy katalogów zdefiniowane w drzewach `OPTIMAL` i `FULL` (np. zamień "Specyfikacje" na `specs/`, "ADR" na `decisions/`, "API" na `contracts/`, "Workflow" na `ai/workflows/`).
* **Wyjaśnienie:** Aktualny przykład używa pojęć ogólnych pisanych z wielkiej litery. Narusza to zasadę *Single Source of Truth (SSOT)* oraz regułę „AI nie powinno zgadywać”. Agent AI czytając `MANIFEST.md` musi otrzymać precyzyjną, techniczną mapę plików, zamiast domyślać się mapowania pojęć na fizyczne katalogi.

* [ ] **2. Usunięcie podziału na odbiorców (Człowiek vs AI) i ujednolicenie praw dostępu do kontekstu**
* **Zadanie:** Usuń z całego dokumentu (oraz z wszelkich tabel opisowych) sugestie, jakoby konkretne katalogi były przeznaczone „wyłącznie dla człowieka” (np. `src/`, `config/`) lub „wyłącznie dla AI” (np. `ai/context/`). W sekcji "Filozofia" dodaj nadrzędną zasadę: *„Repozytorium posiada jedną, całkowicie wspólną strukturę dla człowieka oraz agentów AI. Obie strony korzystają z tych samych katalogów i plików w celu zachowania pełnej symetrii wiedzy o projekcie.”*
* **Wyjaśnienie:** Izolowanie kontekstu (np. twierdzenie, że kod jest dla ludzi, a prompty dla AI) blokuje asystentom AI możliwość analizy środowiska operacyjnego, a ludziom utrudnia kontrolę nad instrukcjami sterującymi agentami. Wspólna struktura to fundament przewidywalności.

* [ ] **3. Wprowadzenie rygorystycznej zasady SSOT dla relacji `ai/context/` oraz `docs/**`
* **Zadanie:** W opisie katalogu `ai/context/` wprowadź bezwzględny zakaz powielania lub skracania opisów technicznych, które znajdują się w głównych katalogach projektu (np. `docs/`, `config/`). Pliki w `ai/context/` (takie jak `architecture.md` czy `stack.md`) mają pełnić funkcję *punktów wejścia* zawierających wyłącznie definicje celów wysokiego poziomu oraz bezpośrednie odnośniki (linki Markdown) do właściwych plików w `docs/architecture/`, `decisions/` czy plików konfiguracyjnych.
* **Wyjaśnienie:** Tworzenie "streszczeń dla AI" obok "pełnej dokumentacji dla ludzi" to bezpośrednie złamanie zasady SSOT. W trakcie rozwoju projektu zmiany w kodzie i `docs/` doprowadzą do rozsynchronizowania ze "streszczeniami" w `ai/context/`. W efekcie AI będzie operować na nieaktualnych danych i generować halucynacje.

* [ ] **4. Unifikacja procesów poprzez scalenie katalogów `playbooks/` oraz `ai/workflows/**`
* **Zadanie:** Całkowicie usuń katalog `playbooks/` z drzewa wersji `FULL` oraz z opisów szczegółowych. Wszystkie procedury operacyjne (np. `release.md`, `rollback.md`, `onboarding.md`) umieść w katalogu `ai/workflows/`. W opisie `ai/workflows/` wskaż, że katalog ten zawiera standardowe procedury krok po kroku, wykonywane ramię w ramię przez człowieka oraz agenty AI.
* **Wyjaśnienie:** Podział na playooki (dla ludzi) i workflowy (dla AI) zmusza zespół do utrzymywania dwóch wersji tej samej procedury (np. wdrożenia na produkcję). Generuje to szum informacyjny i ryzyko błędów. W modelu AI-First procedury operacyjne są uniwersalne i wykonywane w ten sam sposób przez obie strony.

* [ ] **5. Rozgraniczenie ról i definicja odpowiedzialności dla plików zadań (`TODO.md`, `plans/`, `ai/memory/`)**
* **Zadanie:** Doprecyzuj sekcję opisującą pliki zadań, wprowadzając sztywne reguły:
1. Plik `TODO.md` jest jedynym, centralnym miejscem na aktywną, krótkoterminową kolejkę zadań do wykonania (Backlog).
2. Katalog `plans/` zawiera wyłącznie opisy architektoniczne dużych, planowanych zmian (tzw. Epics), do których `TODO.md` odsyła linkami.
3. Katalog `ai/memory/` (np. `technical-debt.md`) służy wyłącznie jako pasywne, historyczne repozytorium wiedzy o stanie zastanym, z zakazem prowadzenia tam list zadań.

* **Wyjaśnienie:** Bez tej separacji agenty AI mają tendencję do rozpraszania długu technicznego i zadań po kilku plikach jednocześnie, co uniemożliwia programiście efektywne zarządzanie priorytetami prac.

* [ ] **6. Zawężenie kompetencji katalogu `ai/prompts/**`
* **Zadanie:** W opisie katalogu `ai/prompts/` dodaj jednoznaczne zastrzeżenie, że służy on *wyłącznie* do przechowywania generycznych, reużywalnych szablonów promptów wywoływanych ręcznie przez człowieka (np. prompt do wykonania specyficznego Code Review). Zabrania się umieszczania tam instrukcji systemowych sterujących agentami, gdyż te należą wyłącznie do `ai/rules/` i `ai/workflows/`.
* **Wyjaśnienie:** Nowoczesne środowiska (Cursor, Claude Code) posiadają własne mechanizmy systemowe. Mieszanie promptów użytkownika z instrukcjami systemowymi w jednym katalogu powoduje, że agenty AI zaczynają traktować pliki pomocnicze jako nadrzędne reguły zachowania.

* [ ] **7. Zabezpieczenie katalogu `tmp/` w konfiguracji systemu kontroli wersji**
* **Zadanie:** W opisie katalogu `tmp/` dodaj bezwzględny nakaz umieszczenia reguły w pliku `.gitignore`, blokującej wysyłanie zawartości folderu `tmp/` (oraz ukrytych logów narzędzi AI, np. `.cursor-tutor`) do zdalnego repozytorium.
* **Wyjaśnienie:** Agenty AI masowo generują pliki tymczasowe, dumpy pamięci i logi z testów. Brak jawnej konfiguracji ignorowania spowoduje automatyczne dodawanie tych śmieciowych danych do indeksu Gita przez agenta, zanieczyszczając historię i wywołując konflikty.

* [ ] **8. Utrzymanie uniwersalności integracji z klientami AI (Odrzucenie konfiguracji dedykowanych)**
* **Zadanie:** W sekcji "Integracja z klientami AI" zachowaj istniejący schemat Mermaid, natomiast usuń wszelkie próby rozpisywania dedykowanych instrukcji dla poszczególnych IDE (Cursor, Windsurf, Roo, Claude Code). Wprowadź jedną, uniwersalną zasadę: *„Wszelkie pliki konfiguracyjne specyficzne dla danego klienta AI (np. `.cursorrules`, `.clinerules`) pełnią rolę wyłącznie technicznego pomostu – powinny zawierać maksymalnie 2-3 linie kodu odsyłające model bezpośrednio do pliku `AGENTS.md`”*.
* **Wyjaśnienie:** Narzędzia i nazwy plików konfiguracyjnych zmieniają się co kilka miesięcy. Rozpisywanie szczegółowych konfiguracji dla każdego klienta AI z osobna niszczy kluczową cechę dokumentu – jego niezależność od IDE i uniwersalność. To narzędzia mają dostosować się do repozytorium, a nie repozytorium do narzędzi.

* [ ] **9. Korekta logiczna kierunku przepływu na schemacie Mermaid**
* **Zadanie:** W kodzie wykresu `mermaid` w sekcji "Integracja z klientami AI" odwróć relację między dokumentacją a specyfikacją, tak aby przepływ wskazywał: `AGENTS.md` -> `ai/context/` -> `specs/` (wymagania biznesowe) -> `docs/` (dokumentacja techniczna i architektura).
* **Wyjaśnienie:** Obecny graf wskazuje kierunek `DOCS` --> `SPECS`, co jest błędem logicznym w inżynierii oprogramowania. Specyfikacja biznesowa (`specs/`) definiuje *co* i *dlaczego* system ma robić, a dokumentacja techniczna (`docs/`) opisuje *jak* to zostało technicznie zaimplementowane na podstawie tych wymagań.

* [ ] **10. Wprowadzenie ścisłej granicy kompetencji pomiędzy `specs/` a `contracts/**`
* **Zadanie:** W opisie katalogu `specs/` dopisz restrykcyjną regułę: pliki w tym katalogu opisują funkcjonalności systemu wyłącznie z perspektywy wymagań biznesowych i kryteriów akceptacji. Formalne, techniczne schematy struktur danych i API (np. OpenAPI, JSON Schema, Protobuf) mogą znajdować się wyłącznie w katalogu `contracts/`. Pliki specyfikacji mają odwoływać się do kontraktów za pomocą linków, bez powielania nazw pól czy typów.
* **Wyjaśnienie:** Brak tego rozróżnienia prowadzi do dublowania struktur danych (słownie w wymaganiach i formalnie w kodzie kontraktu). Dla AI nawet drobna niespójność (np. wielkość liter w nazwie pola) między opisem biznesowym a kontraktem technicznym skutkuje generowaniem wadliwego kodu.

* [ ] **11. Warunkowe zarządzanie terminologią na poziomach MINIMAL i OPTIMAL**
* **Zadanie:** W opisie pliku `ai/context/glossary.md` dodaj adnotację warunkową: *„Na poziomie MINIMAL oraz OPTIMAL (gdzie katalog `knowledge/` jeszcze nie istnieje), plik glossary.md może tymczasowo przechowywać kluczowe terminy biznesowe. W momencie przejścia projektu na poziom FULL, cała wiedza biznesowa musi zostać wyemigrowana do `knowledge/terminology.md`, a `glossary.md` pozostaje miejscem wyłącznie na terminy czysto techniczne/programistyczne z odnośnikiem do pliku biznesowego.”*
* **Wyjaśnienie:** Oryginalna zasada SSOT słusznie rozdziela te pojęcia, jednak katalog `knowledge/` pojawia się dopiero w wersji FULL. Mniejsze projekty zostałyby bez wskazanego miejsca na słownik pojęć, co grozi chaosem w nazewnictwie stosowanym przez AI.

* [ ] **12. Zarządzanie plikami konfiguracyjnymi a wymagania mechanizmu Auto-Discovery narzędzi**
* **Zadanie:** W opisie katalogu `config/` dopisz techniczną uwagę: *„Katalog `config/` stanowi centralne repozytorium dla plików konfiguracyjnych. Jeśli tooling (lintery, kompilatory) wymaga obecności pliku w katalogu głównym (root) do poprawnego auto-discovery, w root należy umieścić plik minimalny, który rozszerza (`extends`) właściwą konfigurację z katalogu `config/` lub zastosować dowiązanie symboliczne (symlink).”*
* **Wyjaśnienie:** Wiele narzędzi deweloperskich przestaje działać w locie, jeśli nie znajdzie pliku konfiguracyjnego bezpośrednio w root projektu. AI opiera się na stabilnym działaniu tych narzędzi, więc ta uwaga zapewnia czystość struktury bez psucia automatyzacji.
