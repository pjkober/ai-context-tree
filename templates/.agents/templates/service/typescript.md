# Code Template: Service (TypeScript)

Use this template when creating a new service class in `src/services/`.

```typescript
// src/services/[name].service.ts

export class [Name]Service {
  constructor(
    private readonly [dependency]: [DependencyType]
  ) {}

  async [methodName]([params]: [ParamType]): Promise<[ReturnType]> {
    // Implementation
  }
}
```

**Naming convention:** `[name].service.ts`, class name `[Name]Service`.
**Rule:** Keep the class under 40 lines per method and under 300 lines total.
**Location:** `src/services/[name].service.ts`
**Test location:** `tests/unit/services/[name].service.test.ts`
