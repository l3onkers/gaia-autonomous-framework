# Few-Shot Example: Multi-Stage CI/CD Pipeline Automation

**Agent:** HEPHAESTUS  
**Skills Resolved:** `hephaestus-build-agent`, `hephaestus-py-cicd`

## Scenario
The user asks to build a complete GitHub Actions CI/CD pipeline for a Python service with testing, security gating, and container image publishing.

## Execution Pattern
1. **Pipeline Triggers:** Scope workflow to PRs targeting `develop` and pushes to `main`.
2. **Quality Stage:** Run linting (`ruff`), typing (`mypy`), and test execution (`pytest`).
3. **Security Gate:** Run dependency checks with MINERVA guidelines.
4. **Build & Package:** Build Docker container using GitHub cache:
   ```yaml
   - name: Build and push Docker image
     uses: docker/build-push-action@v5
     with:
       context: .
       push: ${{ github.ref == 'refs/heads/main' }}
       tags: ${{ steps.meta.outputs.tags }}
       cache-from: type=gha
       cache-to: type=gha,mode=max
   ```
5. **No Placeholders:** All action versions, parameters, and environment references must be fully declared.
