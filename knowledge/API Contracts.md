---
aliases: []
tags:
  - knowledge
<<<<<<< HEAD
=======
  - contracts
  - specs
  - ssot
>>>>>>> dev
type: docs
---

# API Contracts

An **API Contract** is a formal, machine-readable schema file (located in `contracts/`, such as OpenAPI YAML, GraphQL schemas, or Protobuf definitions) that defines endpoint structures, requests, responses, and data types. It serves as a strict boundary between modules or systems.

Using formal contracts is a key practice in [Spec-Driven Development](Spec-Driven%20Development.md). Because AI agents frequently hallucinate field names and data types, having a contract prevents guesswork. The AI agent can automatically generate mock servers, client libraries, and validation tests based on the schema.
