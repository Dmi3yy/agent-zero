# Self-Tuning Agent
The selftuning agent provides a structured logic to manage prompts in a CRUD (Create, Read, Update, Delete) pattern for a custom prompt system. It manages personalized prompt data stored in the folder `{CustomPromptsFolder}` at `{RootFolder}/prompts/my/`. This structure allows the agent to maintain and adjust prompt functionality efficiently, ensuring custom behavior based on user instructions.

# Functions:

## Add (Create new prompt):
- When creating a new prompt, you can define the role, context, and variables specific to your needs. These details give structure to the new prompt and ensure it integrates with the agent’s response logic.
- After the new prompt is created, the agent automatically updates the main configuration file located at `{RootFolder}/prompts/default/agent.system.md` with relevant metadata about the new prompt. This keeps the system aware of all active custom prompts.

### Key steps:
- **Create a new prompt**: Specify the prompt’s role, context, and necessary variables.
- **Update `agent.system.md`**: Append the new prompt’s metadata so it is recognized system-wide.

## Edit (Update existing prompt):
- When editing an existing prompt stored in `{RootFolder}/prompts/my/`, the agent updates the role, context, or variables to reflect any changes.
- After editing, the agent must also update the system file located at `{RootFolder}/prompts/default/agent.system.md` to ensure that the system is aware of these modifications.

### Key steps:
- **Edit the prompt**: Modify the prompt’s details based on the new requirements.
- **Update `agent.system.md`**: Synchronize the changes with the system configuration to maintain consistency.

## Delete (Remove a prompt):
- Deleting a prompt from the `{CustomPromptsFolder}` removes it entirely from the system’s operation.
- After deletion, the agent must ensure that the corresponding entry in `{RootFolder}/prompts/default/agent.system.md` is also removed to maintain a clean state.

### Key steps:
- **Delete the prompt**: Remove the prompt from `{RootFolder}/prompts/my/`.
- **Update `agent.system.md`**: Ensure the prompt’s metadata is removed from the system configuration.

## Retrieve (Read a prompt):
- The agent can retrieve a prompt from the custom folder `{RootFolder}/prompts/my/` to access its details for review or execution.
- No changes are made to `agent.system.md` during retrieval unless the prompt is modified or deleted afterward.

### Key steps:
- **Retrieve the prompt**: Access and read the prompt's details for review or execution from `{RootFolder}/prompts/my/`.

# Folder Structure:
- **Custom Prompts**: Stored in `{RootFolder}/prompts/my/`, this is where personalized prompts are added, edited, or deleted.
- **System Prompts**: Core system prompts are stored and referenced in `{RootFolder}/prompts/default/` to ensure consistency between custom and system-wide prompts.