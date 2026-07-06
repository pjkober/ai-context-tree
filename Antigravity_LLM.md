# Modele LLM w Antigravity: Zestawienie i Strategia Optymalizacji

Jako Senior Developer i architekt AI przygotowałem zestawienie modeli dostępnych w środowisku **Antigravity**. Zrozumienie specyfiki każdego z nich oraz odpowiednie zarządzanie poziomem myślenia (Reasoning Depth) jest kluczem do uzyskania najwyższej jakości kodu przy zachowaniu optymalnego zużycia limitów (quota).

---

## 📊 Tabela Dostępnych Modelów LLM

| Model LLM | Tiers / Warianty | Zużycie Tokenów | Opis, Specyfika i Rekomendowane Zastosowanie |
| :--- | :--- | :--- | :--- |
| **Gemini 3.5 Flash** | `Low`, `Medium`, `High` | **Niski** <br>*(Najbardziej ekonomiczny)* | **Domyślny model do codziennej pracy.** Zoptymalizowany pod kątem szybkości i oszczędności tokenów.<br>• **Do czego stosować:** Proste i rutynowe zadania, drobna refaktoryzacja, formatowanie kodu, wyszukiwanie informacji, generowanie powtarzalnych elementów.<br>• **Co warto wiedzieć:** Wariant `Low` generuje około 45% mniej tokenów niż `Medium`, co znacznie odciąża kontekst. `Medium` to optymalny standard do większości szybkich interakcji. |
| **Gemini 3.1 Pro** | `Low`, `Medium`, `High` | **Średni do Wysokiego** <br>*(Zależy od wybranego poziomu myślenia)* | **Model do zadań wymagających głębszego wnioskowania i analizy.**<br>• **Do czego stosować:** Złożona refaktoryzacja, planowanie architektury, pisanie testów jednostkowych, zaawansowane debugowanie, wieloplikowe zmiany.<br>• **Co warto wiedzieć:** Posiada ogromne okno kontekstowe (1M tokenów) i limit wyjściowy 65k tokenów. Oferuje trójstopniowy system myślenia (Thinking). Poziom `High` zużywa bardzo dużo punktów z puli limitów, dlatego powinien być używany selektywnie. |
| **Claude Sonnet 4.6** | `Thinking` (Domyślnie włączone) | **Wysoki** <br>*(Generuje tokeny myślenia)* | **Flagowy model Anthropic zorientowany na zadania inżynieryjne i precyzję logiczną.**<br>• **Do czego stosować:** Pisanie kodu od zera, trudne algorytmy, analiza skomplikowanej logiki biznesowej, głębokie debugowanie, automatyzacja testów integracyjnych.<br>• **Co warto wiedzieć:** Domyślnie wykorzystuje technologię *Thinking*, co daje wyjątkową dokładność i ścisłe przestrzeganie instrukcji z [AGENTS.md](file:///Users/pjk/code/struktura%20AI-First%20Development/AGENTS.md). Generuje jednak wyższy narzut tokenowy. |
| **Claude Opus 4.6** | `Thinking` (Maksymalne myślenie) | **Bardzo Wysoki** <br>*(Maksymalne zużycie limitów)* | **Model klasy ultra-premium do najcięższych zadań analitycznych.**<br>• **Do czego stosować:** Projektowanie rozbudowanych systemów, nawigacja i analiza potężnych, rozproszonych baz kodu, rozwiązywanie problemów logicznych, z którymi inne modele sobie nie radzą.<br>• **Co warto wiedzieć:** Zużywa limity w bardzo szybkim tempie. Uruchamiaj go jako ostateczność (tzw. "heavy lifter"), gdy Claude Sonnet lub Gemini Pro nie przynoszą zadowalających rezultatów. |
| **GPT-OSS 120B** | `Medium` | **Średni** <br>*(Stabilny MoE)* | **Otwarty model Mixture-of-Experts (MoE) dostarczany przez OpenAI.**<br>• **Do czego stosować:** Stabilne zadania programistyczne, generowanie kodu i dokumentacji w projektach, które dobrze reagują na styl instrukcji OpenAI.<br>• **Specyfika:** Bardzo dobra alternatywa dla Gemini w zadaniach ogólnych. Zapewnia wysoką powtarzalność wyników i zbalansowane zużycie zasobów. |

---

## ⚙️ Poziomy Myślenia (Reasoning Depth) w Antigravity

W Antigravity poziom wnioskowania (ustawiany w konfiguracji agentów lub poprzez CLI) bezpośrednio przekłada się na jakość odpowiedzi oraz liczbę zużytych tokenów:

1. **`MINIMAL` / `LOW`**:
   * **Narzut:** Minimalny.
   * **Zastosowanie:** Zadania o niskim stopniu skomplikowania (np. "dodaj komentarz", "zmień nazwę zmiennej", "uruchom testy").
   * **Zaleta:** Błyskawiczna odpowiedź, minimalne zużycie limitów.
2. **`MEDIUM`**:
   * **Narzut:** Zbalansowany.
   * **Zastosowanie:** Domyślny poziom dla większości zadań programistycznych i analizy pojedynczych plików.
3. **`HIGH`**:
   * **Narzut:** Bardzo duży (włącza głębokie "myślenie" i wieloetapową weryfikację).
   * **Zastosowanie:** Tworzenie planów wdrożenia (Implementation Plans), audyty bezpieczeństwa, debugowanie skomplikowanych błędów wykonania (runtime).
   * **Zaleta:** Znaczący wzrost jakości rozwiązań trudnych problemów kosztem dłuższego czasu generowania.

---

## 💡 Porady Senior Developera: Jak wycisnąć maksimum z Antigravity?

1. **Stosuj Flash jako model pierwszego wyboru:** Do eksploracji repozytorium, prostych zmian i uruchamiania skryptów (np. `create_minimal_structure.sh`) używaj **Gemini 3.5 Flash**. Pozwoli to zachować cenne limity na momenty, gdy będziesz potrzebować głębokiej analizy.
2. **Kieruj kontekstem przez [AGENTS.md](file:///Users/pjk/code/struktura%20AI-First%20Development/AGENTS.md):** Każdy z tych modeli działa znacznie efektywniej, gdy ma precyzyjnie ograniczony kontekst. Zamiast przekazywać całe pliki, stosuj strukturę opisaną w Twoim dokumencie [Uniwersalna struktura projektu dla AI-First Development.md](file:///Users/pjk/code/struktura%20AI-First%20Development/Uniwersalna%20struktura%20projektu%20dla%20AI-First%20Development.md#L105-L110).
3. **Kontroluj swoje zużycie na bieżąco:** Z poziomu terminala Antigravity możesz w każdej chwili sprawdzić stan swoich limitów i aktywny model, wpisując:
   * `/usage` — aktualne zużycie limitów.
   * `/model` — aktualnie wybrany model.
   * `agy models` — aktualna lista modeli bezpośrednio z CLI (w przypadku problemów z uprawnieniami, sprawdź ustawienia w IDE).
