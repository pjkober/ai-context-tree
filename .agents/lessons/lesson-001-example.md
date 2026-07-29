# Lesson: Stripe Webhook Payload Versioning

**ID:** lesson-001
**Date:** 2026-07-07
**Topic:** Webhooks, Stripe API

## Problem / Symptom
Stripe webhook payloads failed parsing, raising `TypeError: Cannot read property 'id' of undefined` during checkout completion.

## Root Cause
Stripe API version `2024-02-12` introduced a breaking change in payload nesting. The payload field shifted from `data.object.id` to a nested metadata structure.

## Resolution & Best Practice
We created a custom fallback parser in `src/payments/parser.js` that checks for both styles. 

**Rule for future agents:**
Always check the Stripe API version used in `package.json` before writing payload extraction logic, and implement a robust nested-property helper (or use `lodash.get`) to avoid parser crashes.
