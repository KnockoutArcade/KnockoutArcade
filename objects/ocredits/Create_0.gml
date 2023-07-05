/// @description Insert description here
// You can write your code in this editor
credits = @"KNOCK-OUT ARCADE


TEAM LEAD
Ryland Kealey - Creator, Art Lead, and Project Lead
John Kidd Jr - Programming Lead
Ian Sbar - Design Lead
Zak Habul - Composer / Sound Lead

ART
Andrea Gutierrez - Character Artist (Beverly)
Bianca Magana - Character Artist (Beverly)
Kaitlyn Nazar - Character Artist (Jay)
Jordan Munoz - Stage Artist

PROGRAMMING
John Kidd Jr - Tools and Engine Programmer
Collin Strauch - Tools and Engine Programmer
Colby Goitia - Programmer
Saul Tellez - Programmer
Kristopher S. Olds - Programmer
Mitchel Kelly - Programmer

DESIGN
Ian Sbar - Move Set Designer
Boone Oliverio - Move Set Designer
Isaiah Burkhart - Asset and World Designer
Gregory Strickland - Enemy Designer
Zachary Cancasci - Level Designer


GAME ENGINE
GameMaker Studio - https://gamemaker.io/

THIRD-PARTY LIBRARIES
SERILOG - https://serilog.net/
NEWTONSOFT JSON - https://newtonsoft.com/json
HARDWARE.INFO - https://github.com/Jinjinov/Hardware.Info
RAYLIB - https://raylib.com/
RAYLIB-CS - https://github.com/ChrisDill/Raylib-cs
DEAR IMGUI - https://github.com/ocornut/imgui
IMGUI.NET - https://github.com/mellinoe/ImGui.NET


THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
";

creditsScrollSpeed = 2;

draw_set_font(creditsFont);
creditsHeight = string_height(credits);
x = room_width/2;
y = room_height;

