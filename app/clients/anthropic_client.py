from anthropic import Anthropic

from app.config import settings


def _client() -> Anthropic:
    return Anthropic(api_key=settings.anthropic_api_key, base_url=settings.anthropic_api_base)


def ask_claude(prompt: str, model: str = "claude-sonnet-5") -> str:
    message = _client().messages.create(
        model=model,
        max_tokens=1024,
        messages=[{"role": "user", "content": prompt}],
    )
    text_blocks = [block.text for block in message.content if block.type == "text"]
    return "".join(text_blocks)
