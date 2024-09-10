import asyncio
from dataclasses import dataclass
from python.helpers.tool import Tool, Response
from python.helpers import files
from python.helpers.print_style import PrintStyle

@dataclass
class FileEditState:
    file_path: str
    content: str

class FileEditTool(Tool):

    async def execute(self, **kwargs):
        await self.agent.handle_intervention()
        file_path = self.args["file_path"]
        section_identifier = self.args["section_identifier"]
        new_content = self.args["new_content"]

        # Step 1: Read the file
        try:
            original_content = files.read_file(file_path)
        except FileNotFoundError:
            return Response(message=f"File '{file_path}' not found.", break_loop=False)

        # Step 2: Find the section
        if section_identifier not in original_content:
            return Response(message=f"Section '{section_identifier}' not found in file.", break_loop=False)

        # Step 3: Replace or add content
        updated_content = original_content.replace(section_identifier, new_content)

        # Step 4: Write the updated content back
        files.write_file(file_path, updated_content)

        # Step 5: Verify changes
        verify_content = files.read_file(file_path)
        if new_content in verify_content:
            return Response(message="File updated successfully.", break_loop=False)
        else:
            return Response(message="Failed to update file.", break_loop=False)

    async def before_execution(self, **kwargs):
        await self.agent.handle_intervention()
        PrintStyle(font_color="#1B4F72", padding=True, background_color="white", bold=True).print(f"{self.agent.agent_name}: Using tool '{self.name}':")

    async def after_execution(self, response, **kwargs):
        msg_response = self.agent.read_prompt("fw.tool_response.md", tool_name=self.name, tool_response=response.message)
        await self.agent.append_message(msg_response, human=True)