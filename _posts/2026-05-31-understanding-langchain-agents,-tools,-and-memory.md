---
layout: post
title: Understanding LangChain Agents, Tools, and Memory
date: 2026-05-31
flashcards:

labels:
- name: Langchain
  color: sky

---
As I started exploring LangChain, I quickly realized that building AI applications is much more than sending prompts to a language model and getting responses back. Concepts like agents, tools, memory, and configuration play a crucial role in making applications more intelligent and useful.

In this post, I want to share some of the key concepts I learned while experimenting with LangChain and building my first agent-based workflows.

## Understanding Agents

One of the first concepts I encountered was the `Agent`.

An agent can be thought of as a decision-making layer on top of a language model. Instead of simply generating text, an agent can decide when to use external tools, gather information, and perform actions before generating a final response.

This makes agents much more capable than a standalone `LLM` because they can interact with the outside world rather than relying solely on their training data.

While working with agents, I came across an important configuration called `Temperature`.

## Temperature: Controlling Creativity

The temperature parameter controls the randomness of the model's output.

Typically, the value ranges from **0 to 1**, although some models support values greater than 1.

### Lower Temperature

When the temperature is set closer to **0**:

- Responses become more deterministic.
- The model produces consistent outputs.
- Reasoning tends to be more logical and predictable.
- Useful for coding, analysis, data extraction, and structured tasks.

For example, if I ask the same question multiple times with a temperature of 0, the answer will usually be nearly identical.

### Higher Temperature

When the temperature is increased:

- Responses become more diverse.
- The model explores more possibilities.
- Creativity increases.
- Useful for storytelling, brainstorming, and content generation.

A higher temperature can make outputs feel more human and imaginative, although it may also introduce inconsistency.

One of my early takeaways was that choosing the right temperature depends entirely on the use case. There is no universally "best" setting.

## Working with Tools

The next concept that caught my attention was `Tools`.

Tools allow an agent to execute code or interact with external systems whenever necessary.

Instead of forcing the language model to answer everything from memory, we can provide specialized functions that the agent can call.

For example:

- Querying a database
- Fetching information from an API
- Performing calculations
- Accessing files
- Running custom business logic

In LangChain, creating tools is surprisingly straightforward.

### Default Tool Name

If a Python function is registered as a tool, the function name is used as the tool name by default.

For example:

```
@tool
def get_weather(city: str):
    """Get weather information."""
```

In this case, the tool name becomes:

```
get_weather
```

The function's docstring is also used as the tool description.

### Custom Tool Names

LangChain also allows custom naming.

```
@tool(
    "weather_lookup",
    description="Get current weather information."
)
def get_weather(city: str):
    pass
```

Now the agent sees the tool as:

```
weather_lookup
```

instead of the original function name.

This can be useful when creating more descriptive or user-friendly tool names.

### Tool Descriptions Matter

One thing I learned quickly is that descriptions are incredibly important.

The agent decides whether to use a tool based largely on the tool's description.

A vague description can confuse the agent, while a clear description significantly improves tool selection.

Good descriptions answer:

- What does the tool do?
- When should it be used?
- What kind of input does it expect?

The better the description, the better the agent's decision-making.

## Understanding Memory

Perhaps the most interesting concept for me was **Memory**.

Without memory, every interaction would feel like a completely new conversation.

Memory allows agents to retain context and build upon previous interactions.

### Short-Term Memory

The first type of memory I explored was short-term memory.

Short-term memory stores information about the current conversation and makes that context available for future responses.

This enables experiences such as:

- Follow-up questions
- Context-aware responses
- Multi-step workflows
- Ongoing conversations

Instead of repeatedly providing the same information, the agent can remember details from earlier messages.

## Checkpointers

LangChain uses a concept called a `Checkpointer` to persist conversation state.

A checkpointer acts as a storage mechanism for messages and agent state.

Whenever a conversation progresses, the checkpointer saves the current state so it can be restored later.

This becomes especially useful when:

- Conversations span multiple requests
- Applications restart
- Multiple users interact with the system

The checkpointer ensures continuity.

## Thread IDs and Conversation Context

Another concept I found particularly useful is the **thread_id**.

Messages that share the same thread ID belong to the same conversation.

When an agent receives a request, the thread ID is usually provided through the configuration.

For example:

```
config = {
    "configurable": {
        "thread_id": "user-123"
    }
}
```

All interactions using this thread ID can access the same conversation history.

If a different thread ID is used:

```
config = {
    "configurable": {
        "thread_id": "user-456"
    }
}
```

`LangChain` treats it as a completely separate conversation.

This mechanism makes it possible to manage multiple users and multiple conversations simultaneously while keeping their contexts isolated.

## My Key Takeaways

After learning these concepts, I started to see how LangChain pieces fit together:

- `Agents` act as decision-makers.
- `Temperature` controls creativity and randomness.
- `Tools` allow agents to interact with external systems.
- `Tool descriptions` strongly influence agent behavior.
- `Memory` provides conversational context.
- `Checkpointers` persist conversation state.
- `thread_id` separates and maintains individual conversation histories.

What initially looked like a collection of independent concepts gradually started to feel like a complete framework for building intelligent AI applications. Understanding how agents use tools and memory together was the moment when LangChain finally clicked for me.

This is still the beginning of my LangChain learning journey, but these foundational concepts have given me a much clearer picture of how modern AI applications are built.
