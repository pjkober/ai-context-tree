# Terminology Management

To ensure clear communication between developers, business stakeholders, and AI agents, projects must manage terminology cleanly and avoid mixing technical jargon with domain-specific terms.

## Differentiating Term Categories

1. **Technical Term:** A concept related to the technology stack, software design patterns, or repository architecture (e.g. "Repository Pattern", "Feature flag", "Middleware", "ADR"). These are technology-dependent and independent of the client's industry.
2. **Business Term:** A concept related to the business domain, understandable by non-technical people (e.g. "Underwriting", "Completed order", "VIP client", "Premium calculation").

## Rules for Terminology Evolution

The glossary starts simple and expands dynamically as the project grows:

1. **Small Projects:**
   As long as the domain terminology is small, all terms (both business and technical) are stored in a single file: `ai/context/glossary.md`.

2. **Growing Projects:**
   Once the business domain grows too large to fit in a single glossary file, create the dedicated directory `knowledge/terminology/` (each term gets its own small markdown file following the *one topic = one file* rule).
   
3. **SSOT Term Separation:**
   - Business terms migrate entirely to `knowledge/terminology/`.
   - `ai/context/glossary.md` is updated to contain **only** technical terms.
   - If a technical term in `glossary.md` is closely linked to a business concept, it should refer to it via a markdown link (e.g. `[Order](../../knowledge/terminology/order.md)`) instead of duplicating the definition.
   - Definitions in `ai/context/glossary.md` must always be kept to a single sentence.
