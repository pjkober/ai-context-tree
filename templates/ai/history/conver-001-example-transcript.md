# Conversation: Setup Payments Module

**ID:** conver-001
**Date:** 2026-07-07
**Participants:** Developer, Claude Code

## Summary
In this conversation, we integrated the Stripe API for subscription payments. We decided to use standard webhook handlers to process checkout events asynchronously.

## Architectural Decisions
- We chose Stripe instead of PayPal (see ADR 003).
- We placed Stripe secret keys under `.env` and loaded them via configuration layers (No Secrets Rule).

## Key Discoveries
- Stripe API version `2024-02-12` has a breaking change in the webhook payload structure. We handled this by adding a fallback parser in `src/payments/parser.js`.
