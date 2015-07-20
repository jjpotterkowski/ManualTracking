package ManualTracking "Modelica manual tracking library"
  extends Modelica.Icons.Package;
  package UsersGuide "User's guide"
    extends Modelica.Icons.Information;
    class Introduction "Introduction to manual tracking"
      extends Modelica.Icons.Information;
      annotation(preferredView = "info", Documentation(info = "<html>
<p>
There are many situations where a human operator is required to make the output
of a system follow a desired trajectory.  Examples of manual tracking tasks 
include aiming a tank turret, driving an automobile, and piloting an aircraft.
</p>

<p>
Note that to simulate one of these systems, a model of the human's control 
behavior must be specified.  Such models can be found in the field of 
<i>manual control</i>, which uses the tools and techniques of control theory
to study the control behavior of humans.
</p>

<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Diagr-TrackingDisplay.png\" alt=\"Diagr-TrackingDisplay\">
</p>

<p>
Previous studies have made extensive use of single-axis manual tracking tasks
 to investigate the control behavior of humans performing continuous control.
In a typical experimental tracking task, a human operator views a display on 
a computer screen and uses an input device, such as a joystick or force stick, 
to generate control input.  An example display is shown above.  There are two 
objects on the screen: one is a <i>target</i> that represents the reference
(desired) state, and the other is a <i>cursor</i> that represents the actual
state of the controlled system.  The human's goal is to make the cursor follow
the target as closely as possible.  
</p>

<p>
Many situations require humans to perform multi-axis, multi-loop control tasks,
so it might seem that studying one-dimensional control would be an unreasonable
oversimplification. However, it has been found that multi-axis tracking 
performance is highly related to one-axis tracking, and that information about
the human controller derived from single-axis tracking tasks can be applied
to multi-loop tasks.
</p>

<p>
This library contains dynamic models of human control behavior from the 
manual control literature.  In addition, Python-based tools allow users to 
perform manual tracking tasks designed in Modelica, and to tune parameter 
values in the manual controller models to either maximize tracking performance,
or to match recorded control input from user experiments.
</p>
</html>"));
    end Introduction;
    class PythonFunctions "Python functions included with ManualTracking library"
      extends Modelica.Icons.Information;
      annotation(preferredView = "info", Documentation(info = "<html>
<p>
In addition to Modelca-based components, two additional capabilities are 
provided in the ManualTracking library: automatically tuning manual controller
parameters, and performing real-time tracking experiments.  These features are
implemented in the Python programming language, version 2.7.  
</p>

<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Diagr-SoftwareOverview.png\" alt=\"Diagr-SoftwareOverview\">
</p>

<p>
An overview of the software is shown above.  In the <i>Resources/</i> 
directory, there are 5 .py files.  Four of these are function scripts that can
be run from a terminal or Python IDE, and the fifth file is <i>Options.py</i>,
where options are set by the user.  The functions donot use input arguments,
and instead look at <i>Options.py</i>.  Variables in this file include: 
<b>taskModel</b>, the tracking task model to run; <b>jmodelicaPath</b> 
the JModelica.org install path; <b>saveFormat</b>, the format with which to 
save backup data files; and <b>printVerbose</b>, whether or not to print all
runtime messages to the console.
</p>

<p>
<b>Options.py</b> also contains Boolean input arguments for each of the four 
functions: <b>useSaved</b> makes the functions use most recent saved data 
(in <i>Resources/Temp/</i> directory) instead of re-running an experiment; 
<b>plotResults</b> generates a figure with the resulting curves; 
<b>printResults</b> prints a summary of the results to the console; and 
<b>saveResults</b> saves a backup results file in the <i>Resources/Data/</i>
directory.
</p>

<p>
Each of the four main functions call <i>mantra.py</i>, which reads the 
<i>ManualTracking.mo</i> file for details of the tracking task, and then calls 
functions defined in <i>fmi.py</i>, <i>game.py</i>, and <i>tools.py</i>.
These functions use standard Python modules, as well as OMPython, pyfmi, 
pyjmi, Pygame, and matplotlib.  
</p>
</html>"));
    end PythonFunctions;
    class ModelicaLicense2 "Modelica License 2"
      extends Modelica.Icons.Information;
      annotation(Documentation(info = "<html>
<head>
	<title>The Modelica License 2</title>
<style type=\"text/css\">
*       { font-size: 10pt; font-family: Arial,sans-serif; }
code    { font-size:  9pt; font-family: Courier,monospace;}
h6      { font-size: 10pt; font-weight: bold; color: green; }
h5      { font-size: 11pt; font-weight: bold; color: green; }
h4      { font-size: 13pt; font-weight: bold; color: green; }
address {                  font-weight: normal}
td      { solid #000; vertical-align:top; }
th      { solid #000; vertical-align:top; font-weight: bold; }
table   { solid #000; border-collapse: collapse;}
</style>
</head>
<body lang=\"en-US\">

<p>
This package with all of its subpackages is released
under the &ldquo;Modelica License 2&rdquo; (if not explicitly noted otherwise).</p>

<p>
<a href=\"#The_Modelica_License_2-outline\">The Modelica License 2</a><br>
<a href=\"#How_to_Apply_the_Modelica_License_2-outline\">How to Apply the Modelica License 2</a><br>
<a href=\"#Frequently_Asked_Questions-outline\">Frequently Asked Questions</a><br>
</p>

<hr>

<h4><a name=\"The_Modelica_License_2-outline\"></a>The Modelica License 2</h4>

<p>
<b>Preamble.</b> The goal of this license is that Modelica related
model libraries, software, images, documents, data files etc. can be
used freely in the original or a modified form, in open source and in
commercial environments (as long as the license conditions below are
fulfilled, in particular sections 2c) and 2d). The Original Work is
provided free of charge and the use is completely at your own risk.
Developers of free Modelica packages are encouraged to utilize this
license for their work.</p>

<p>
The Modelica License applies to any Original Work that contains the
following licensing notice adjacent to the copyright notice(s) for
this Original Work:</p>

<p><b>Licensed by &lt;name of Licensor&gt; under the Modelica License 2</b></p>

<p><b>1. Definitions.</b></p>
<ol type=\"a\">
	<li>&ldquo;License&rdquo; is this Modelica License.</li>

	<li>&ldquo;Original Work&rdquo; is any work of authorship, including
	software, images, documents, data files, that contains the above
	licensing notice or that is packed together with a licensing notice
	referencing it.</li>

	<li>&ldquo;Licensor&rdquo; is the provider of the Original Work who has
	placed this licensing notice adjacent to the copyright notice(s) for
	the Original Work. The Original Work is either directly provided by
	the owner of the Original Work, or by a licensee of the owner.</li>

	<li>&ldquo;Derivative Work&rdquo; is any modification of the Original
	Work which represents, as a whole, an original work of authorship.
	For the matter of clarity and as examples:

	<ol  type=\"A\">
		<li>Derivative Work shall not include work that remains separable from
		the Original Work, as well as merely extracting a part of the
		Original Work without modifying it.</li>

		<li>Derivative Work shall not include (a) fixing of errors and/or (b)
		adding vendor specific Modelica annotations and/or (c) using a
		subset of the classes of a Modelica package, and/or (d) using a
		different representation, e.g., a binary representation.</li>

		<li>Derivative Work shall include classes that are copied from the
		Original Work where declarations, equations or the documentation
		are modified.</li>

		<li>Derivative Work shall include executables to simulate the models
		that are generated by a Modelica translator based on the Original
		Work (of a Modelica package).</li>
	</ol>

	<li>&ldquo;Modified Work&rdquo; is any modification of the Original Work
	with the following exceptions: (a) fixing of errors and/or (b)
	adding vendor specific Modelica annotations and/or (c) using a
	subset of the classes of a Modelica package, and/or (d) using a
	different representation, e.g., a binary representation.</li>

	<li>&quot;Source Code&quot; means the preferred form of the Original
	Work for making modifications to it and all available documentation
	describing how to modify the Original Work.</li>

	<li>&ldquo;You&rdquo; means an individual or a legal entity exercising
	rights under, and complying with all of the terms of, this License.</li>

	<li>&ldquo;Modelica package&rdquo; means any Modelica library that is
	defined with the &ldquo;<code><b>package</b>&nbsp;&lt;Name&gt;&nbsp;...&nbsp;<b>end</b>&nbsp;&lt;Name&gt;;</code>&rdquo; Modelica language element.</li>

</ol>

<p>
<b>2. Grant of Copyright License.</b> Licensor grants You a
worldwide, royalty-free, non-exclusive, sublicensable license, for
the duration of the copyright, to do the following:</p>

<ol type=\"a\">
	<li><p>
	To reproduce the Original Work in copies, either alone or as part of
	a collection.</p></li>
	<li><p>
	To create Derivative Works according to Section 1d) of this License.</p></li>
	<li><p>
	To distribute or communicate to the public copies of the <u>Original
	Work</u> or a <u>Derivative Work</u> under <u>this License</u>. No
	fee, neither as a copyright-license fee, nor as a selling fee for
	the copy as such may be charged under this License. Furthermore, a
	verbatim copy of this License must be included in any copy of the
	Original Work or a Derivative Work under this License.<br>
	For the matter of clarity, it is permitted A) to distribute or
	communicate such copies as part of a (possible commercial)
	collection where other parts are provided under different licenses
	and a license fee is charged for the other parts only and B) to
	charge for mere printing and shipping costs.</p></li>
	<li><p>
	To distribute or communicate to the public copies of a <u>Derivative
	Work</u>, alternatively to Section 2c), under <u>any other license</u>
	of your choice, especially also under a license for
	commercial/proprietary software, as long as You comply with Sections
	3, 4 and 8 below. <br>      For the matter of clarity, no
	restrictions regarding fees, either as to a copyright-license fee or
	as to a selling fee for the copy as such apply.</p></li>
	<li><p>
	To perform the Original Work publicly.</p></li>
	<li><p>
	To display the Original Work publicly.</p></li>
</ol>

<p>
<b>3. Acceptance.</b> Any use of the Original Work or a
Derivative Work, or any action according to either Section 2a) to 2f)
above constitutes Your acceptance of this License.</p>

<p>
<b>4. Designation of Derivative Works and of Modified Works.
</b>The identifying designation of Derivative Work and of Modified
Work must be different to the corresponding identifying designation
of the Original Work. This means especially that the (root-level)
name of a Modelica package under this license must be changed if the
package is modified (besides fixing of errors, adding vendor specific
Modelica annotations, using a subset of the classes of a Modelica
package, or using another representation, e.g. a binary
representation).</p>

<p>
<b>5. Grant of Patent License.</b>
Licensor grants You a worldwide, royalty-free, non-exclusive, sublicensable license,
under patent claims owned by the Licensor or licensed to the Licensor by
the owners of the Original Work that are embodied in the Original Work
as furnished by the Licensor, for the duration of the patents,
to make, use, sell, offer for sale, have made, and import the Original Work
and Derivative Works under the conditions as given in Section 2.
For the matter of clarity, the license regarding Derivative Works covers
patent claims to the extent as they are embodied in the Original Work only.</p>

<p>
<b>6. Provision of Source Code.</b> Licensor agrees to provide
You with a copy of the Source Code of the Original Work but reserves
the right to decide freely on the manner of how the Original Work is
provided.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For the matter of clarity, Licensor might provide only a binary
representation of the Original Work. In that case, You may (a) either
reproduce the Source Code from the binary representation if this is
possible (e.g., by performing a copy of an encrypted Modelica
package, if encryption allows the copy operation) or (b) request the
Source Code from the Licensor who will provide it to You.</p>

<p>
<b>7. Exclusions from License Grant.</b> Neither the names of
Licensor, nor the names of any contributors to the Original Work, nor
any of their trademarks or service marks, may be used to endorse or
promote products derived from this Original Work without express
prior permission of the Licensor. Except as otherwise expressly
stated in this License and in particular in Sections 2 and 5, nothing
in this License grants any license to Licensor&rsquo;s trademarks,
copyrights, patents, trade secrets or any other intellectual
property, and no patent license is granted to make, use, sell, offer
for sale, have made, or import embodiments of any patent claims.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No license is granted to the trademarks of
Licensor even if such trademarks are included in the Original Work,
except as expressly stated in this License. Nothing in this License
shall be interpreted to prohibit Licensor from licensing under terms
different from this License any Original Work that Licensor otherwise
would have a right to license.</p>

<p>
<b>8. Attribution Rights.</b> You must retain in the Source
Code of the Original Work and of any Derivative Works that You
create, all author, copyright, patent, or trademark notices, as well
as any descriptive text identified therein as an &quot;Attribution
Notice&quot;. The same applies to the licensing notice of this
License in the Original Work. For the matter of clarity, &ldquo;author
notice&rdquo; means the notice that identifies the original
author(s). <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You must cause the Source Code for any Derivative
Works that You create to carry a prominent Attribution Notice
reasonably calculated to inform recipients that You have modified the
Original Work. <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In case the Original Work or Derivative Work is not provided in
Source Code, the Attribution Notices shall be appropriately
displayed, e.g., in the documentation of the Derivative Work.</p>

<p><b>9. Disclaimer
of Warranty. <br></b><u><b>The Original Work is provided under this
License on an &quot;as is&quot; basis and without warranty, either
express or implied, including, without limitation, the warranties of
non-infringement, merchantability or fitness for a particular
purpose. The entire risk as to the quality of the Original Work is
with You.</b></u> This disclaimer of warranty constitutes an
essential part of this License. No license to the Original Work is
granted by this License except under this disclaimer.</p>

<p>
<b>10. Limitation of Liability.</b> Under no circumstances and
under no legal theory, whether in tort (including negligence),
contract, or otherwise, shall the Licensor, the owner or a licensee
of the Original Work be liable to anyone for any direct, indirect,
general, special, incidental, or consequential damages of any
character arising as a result of this License or the use of the
Original Work including, without limitation, damages for loss of
goodwill, work stoppage, computer failure or malfunction, or any and
all other commercial damages or losses. This limitation of liability
shall not apply to the extent applicable law prohibits such
limitation.</p>

<p>
<b>11. Termination.</b> This License conditions your rights to
undertake the activities listed in Section 2 and 5, including your
right to create Derivative Works based upon the Original Work, and
doing so without observing these terms and conditions is prohibited
by copyright law and international treaty. Nothing in this License is
intended to affect copyright exceptions and limitations. This License
shall terminate immediately and You may no longer exercise any of the
rights granted to You by this License upon your failure to observe
the conditions of this license.</p>

<p>
<b>12. Termination for Patent Action.</b> This License shall
terminate automatically and You may no longer exercise any of the
rights granted to You by this License as of the date You commence an
action, including a cross-claim or counterclaim, against Licensor,
any owners of the Original Work or any licensee alleging that the
Original Work infringes a patent. This termination provision shall
not apply for an action alleging patent infringement through
combinations of the Original Work under combination with other
software or hardware.</p>

<p>
<b>13. Jurisdiction.</b> Any action or suit relating to this
License may be brought only in the courts of a jurisdiction wherein
the Licensor resides and under the laws of that jurisdiction
excluding its conflict-of-law provisions. The application of the
United Nations Convention on Contracts for the International Sale of
Goods is expressly excluded. Any use of the Original Work outside the
scope of this License or after its termination shall be subject to
the requirements and penalties of copyright or patent law in the
appropriate jurisdiction. This section shall survive the termination
of this License.</p>

<p>
<b>14. Attorneys&rsquo; Fees.</b> In any action to enforce the
terms of this License or seeking damages relating thereto, the
prevailing party shall be entitled to recover its costs and expenses,
including, without limitation, reasonable attorneys' fees and costs
incurred in connection with such action, including any appeal of such
action. This section shall survive the termination of this License.</p>

<p>
<b>15. Miscellaneous.</b>
</p>
<ol type=\"a\">
	<li>If any
	provision of this License is held to be unenforceable, such
	provision shall be reformed only to the extent necessary to make it
	enforceable.</li>

	<li>No verbal
	ancillary agreements have been made. Changes and additions to this
	License must appear in writing to be valid. This also applies to
	changing the clause pertaining to written form.</li>

	<li>You may use the
	Original Work in all ways not otherwise restricted or conditioned by
	this License or by law, and Licensor promises not to interfere with
	or be responsible for such uses by You.</li>
</ol>

<hr>

<h4><a name=\"How_to_Apply_the_Modelica_License_2-outline\"></a>
How to Apply the Modelica License 2</h4>

<p>At
the top level of your Modelica package and at every important
subpackage, add the following notices in the info layer of the
package:</p>

<p>
Licensed by &lt;Licensor&gt; under the Modelica License 2<br>
Copyright &copy; &lt;year1&gt;-&lt;year2&gt;, &lt;name of copyright
holder(s)&gt;.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

<p>Include
a copy of the Modelica License 2 under
<b>&lt;library&gt;.UsersGuide.ModelicaLicense2</b>
(use <a href=\"http://www.modelica.org/licenses/ModelicaLicense2.mo\">
http://www.modelica.org/licenses/ModelicaLicense2.mo</a>).
Furthermore, add
the list of authors and contributors under
<b>&lt;library&gt;.UsersGuide.Contributors</b> or
<b>&lt;library&gt;.UsersGuide.Contact</b>.</p>

<p>For
example, sublibrary Modelica.Blocks of the Modelica Standard Library
may have the following notices:</p>

<p>
Licensed by Modelica Association under the Modelica License 2<br>
Copyright &copy; 1998-2008, Modelica Association.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

<p>For
C-source code and documents, add similar notices in the corresponding
file.</p>

<p>For
images, add a &ldquo;readme.txt&rdquo; file to the directories where
the images are stored and include a similar notice in this file.</p>

<p>In
these cases, save a copy of the Modelica License 2 in one directory
of the distribution, e.g.,
<a href=\"http://www.modelica.org/licenses/ModelicaLicense2.html\">
http://www.modelica.org/licenses/ModelicaLicense2.html</a>
in directory <b>&lt;library&gt;/Resources/Documentation/ModelicaLicense2.html</b>.
</p>

<hr>

<h5><a name=\"Frequently_Asked_Questions-outline\"></a>
Frequently Asked Questions</h5>
<p>This
section contains questions/answer to users and/or distributors of
Modelica packages and/or documents under Modelica License 2. Note,
the answers to the questions below are not a legal interpretation of
the Modelica License 2. In case of a conflict, the language of the
license shall prevail.</p>

<h6>Using or Distributing a Modelica <u>Package</u> under the Modelica License 2</h6>

<p><b>What are the main
differences to the previous version of the Modelica License?</b></p>
<ol>
	<li><p>
	Modelica License 1 is unclear whether the licensed Modelica package
	can be distributed under a different license. Version 2 explicitly
	allows that &ldquo;Derivative Work&rdquo; can be distributed under
	any license of Your choice, see examples in Section 1d) as to what
	qualifies as Derivative Work (so, version 2 is clearer).</p>
	<li><p>
	If You modify a Modelica package under Modelica License 2 (besides
	fixing of errors, adding vendor specific Modelica annotations, using
	a subset of the classes of a Modelica package, or using another
	representation, e.g., a binary representation), you must rename the
	root-level name of the package for your distribution. In version 1
	you could keep the name (so, version 2 is more restrictive). The
	reason of this restriction is to reduce the risk that Modelica
	packages are available that have identical names, but different
	functionality.</p>
	<li><p>
	Modelica License 1 states that &ldquo;It is not allowed to charge a
	fee for the original version or a modified version of the software,
	besides a reasonable fee for distribution and support&rdquo;.
	Version 2 has a similar intention for all Original Work under
	<u>Modelica License 2</u> (to remain free of charge and open source)
	but states this more clearly as &ldquo;No fee, neither as a
	copyright-license fee, nor as a selling fee for the copy as such may
	be charged&rdquo;. Contrary to version 1, Modelica License 2 has no
	restrictions on fees for Derivative Work that is provided under a
	different license (so, version 2 is clearer and has fewer
	restrictions).</p>
	<li><p>
	Modelica License 2 introduces several useful provisions for the
	licensee (articles 5, 6, 12), and for the licensor (articles 7, 12,
	13, 14) that have no counter part in version 1.</p>
	<li><p>
	Modelica License 2 can be applied to all type of work, including
	documents, images and data files, contrary to version 1 that was
	dedicated for software only (so, version 2 is more general).</p>
</ol>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) as part of my commercial
Modelica modeling and simulation environment?</b></p>
<p>Yes,
according to Section 2c). However, you are not allowed to charge a
fee for this part of your environment. Of course, you can charge for
your part of the environment.
</p>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) under a different
license?</b></p>
<p>No.
The license of an unmodified Modelica package cannot be changed
according to Sections 2c) and 2d). This means that you cannot <u>sell</u>
copies of it, any distribution has to be free of charge.</p>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) under a different license
when I first encrypt the package?</b></p>
<p>No.
Merely encrypting a package does not qualify for Derivative Work and
therefore the encrypted package has to stay under Modelica License 2.</p>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) under a different license
when I first add classes to the package?</b></p>
<p>No.
The package itself remains unmodified, i.e., it is Original Work, and
therefore the license for this part must remain under Modelica
License 2. The newly added classes can be, however, under a different
license.
</p>

<p><b>Can
I copy a class out of a Modelica package (under Modelica License 2)
and include it </b><u><b>unmodified</b></u><b> in a Modelica package
under a </b><u><b>commercial/proprietary license</b></u><b>?</b></p>
<p>No,
according to article 2c). However, you can include model, block,
function, package, record and connector classes in your Modelica
package under <u>Modelica License 2</u>. This means that your
Modelica package could be under a commercial/proprietary license, but
one or more classes of it are under Modelica License 2.<br>Note, a
&ldquo;type&rdquo; class (e.g., type Angle = Real(unit=&rdquo;rad&rdquo;))
can be copied and included unmodified under a commercial/proprietary
license (for details, see the next question).</p>

<p><b>Can
I copy a type class or </b><u><b>part</b></u><b> of a model, block,
function, record, connector class, out of a Modelica package (under
Modelica License 2) and include it modified or unmodified in a
Modelica package under a </b><u><b>commercial/proprietary</b></u><b>
license</b></p>
<p>Yes,
according to article 2d), since this will in the end usually qualify
as Derivative Work. The reasoning is the following: A type class or
part of another class (e.g., an equation, a declaration, part of a
class description) cannot be utilized &ldquo;by its own&rdquo;. In
order to make this &ldquo;usable&rdquo;, you have to add additional
code in order that the class can be utilized. This is therefore
usually Derivative Work and Derivative Work can be provided under a
different license. Note, this only holds, if the additional code
introduced is sufficient to qualify for Derivative Work. Merely, just
copying a class and changing, say, one character in the documentation
of this class would be no Derivative Work and therefore the copied
code would have to stay under Modelica License 2.</p>

<p><b>Can
I copy a class out of a Modelica package (under Modelica License 2)
and include it in </b><u><b>modified </b></u><b>form in a
</b><u><b>commercial/proprietary</b></u><b> Modelica package?</b></p>
<p>Yes.
If the modification can be seen as a &ldquo;Derivative Work&rdquo;,
you can place it under your commercial/proprietary license. If the
modification does not qualify as &ldquo;Derivative Work&rdquo; (e.g.,
bug fixes, vendor specific annotations), it must remain under
Modelica License 2. This means that your Modelica package could be
under a commercial/proprietary license, but one or more parts of it
are under Modelica License 2.</p>

<p><b>Can I distribute a
&ldquo;save total model&rdquo; under my commercial/proprietary
license, even if classes under Modelica License 2 are included?</b></p>
<p>Your
classes of the &ldquo;save total model&rdquo; can be distributed
under your commercial/proprietary license, but the classes under
Modelica License 2 must remain under Modelica License 2. This means
you can distribute a &ldquo;save total model&rdquo;, but some parts
might be under Modelica License 2.</p>

<p><b>Can I distribute a
Modelica package (under Modelica License 2) in encrypted form?</b></p>
<p>Yes.
Note, if the encryption does not allow &ldquo;copying&rdquo; of
classes (in to unencrypted Modelica source code), you have to send
the Modelica source code of this package to your customer, if he/she
wishes it, according to article&nbsp;6.</p>

<p><b>Can I distribute an
executable under my commercial/proprietary license, if the model from
which the executable is generated uses models from a Modelica package
under Modelica License 2?</b></p>
<p>Yes,
according to article 2d), since this is seen as Derivative Work. The
reasoning is the following: An executable allows the simulation of a
concrete model, whereas models from a Modelica package (without
pre-processing, translation, tool run-time library) are not able to
be simulated without tool support. By the processing of the tool and
by its run-time libraries, significant new functionality is added (a
model can be simulated whereas previously it could not be simulated)
and functionality available in the package is removed (e.g., to build
up a new model by dragging components of the package is no longer
possible with the executable).</p>

<p><b>Is my modification to
a Modelica package (under Modelica License 2) a Derivative Work?</b></p>
<p>It
is not possible to give a general answer to it. To be regarded as &quot;an
original work of authorship&quot;, a derivative work must be
different enough from the original or must contain a substantial
amount of new material. Making minor changes or additions of little
substance to a preexisting work will not qualify the work as a new
version for such purposes.
</p>

<h6>Using or Distributing a Modelica <u>Document</u> under the Modelica License 2</h6>

<p>This
section is devoted especially for the following applications:</p>
<ol type=\"a\">
	<li><p>
	A Modelica tool extracts information out of a Modelica package and
	presents the result in form of a &ldquo;manual&rdquo; for this
	package in, e.g., html, doc, or pdf format.</p>
	<li><p>
	The Modelica language specification is a document defining the
	Modelica language. It will be licensed under Modelica License 2.</p>
	<li><p>
	Someone writes a book about the Modelica language and/or Modelica
	packages and uses information which is available in the Modelica
	language specification and/or the corresponding Modelica package.</p>
</ol>

<p><b>Can I sell a manual
that was basically derived by extracting information automatically
from a Modelica package under Modelica License 2 (e.g., a &ldquo;reference
guide&rdquo; of the Modelica Standard Library):</b></p>
<p>Yes.
Extracting information from a Modelica package, and providing it in a
human readable, suitable format, like html, doc or pdf format, where
the content is significantly modified (e.g. tables with interface
information are constructed from the declarations of the public
variables) qualifies as Derivative Work and there are no restrictions
to charge a fee for Derivative Work under alternative 2d).</p>

<p><b>Can
I copy a text passage out of a Modelica document (under Modelica
License 2) and use it </b><u><b>unmodified</b></u><b> in my document
(e.g. the Modelica syntax description in the Modelica Specification)?</b></p>
<p>Yes.
In case you distribute your document, the copied parts are still
under Modelica License 2 and you are not allowed to charge a license
fee for this part. You can, of course, charge a fee for the rest of
your document.</p>

<p><b>Can
I copy a text passage out of a Modelica document (under Modelica
License 2) and use it in </b><u><b>modified</b></u><b> form in my
document?</b></p>
<p>Yes,
the creation of Derivative Works is allowed. In case the content is
significantly modified this qualifies as Derivative Work and there
are no restrictions to charge a fee for Derivative Work under
alternative 2d).</p>

<p><b>Can I sell a printed
version of a Modelica document (under Modelica License 2), e.g., the
Modelica Language Specification?</b></p>
<p>No,
if you are not the copyright-holder, since article 2c) does not allow
a selling fee for a (in this case physical) copy. However, mere
printing and shipping costs may be recovered.</p>
</body>
</html>"));
    end ModelicaLicense2;
    class References "References"
      extends Modelica.Icons.References;
      annotation(preferredView = "info", Documentation(info = "<html>
<p>
F. M. Drop, D. M. Pool, H. J. Damveld, M. M. van Paassen, and M. Mulder.  
Identification of the feedforward component in manual control with predictable target signals. 
<i>IEEE Transactions on Cybernetics</i>, 
43(6):1936--1949, Dec. 2013.
</p>

<p>
R. Hosman and H. Stassen.
Pilot's perception in the control of aircraft motions.
<i>Control Engineering Practice</i>, 
7:1421--1428, 1999.
</p>

<p>
H. R. Jex, J. D. McDonnell, and A. V. Phatak.
A &quot;critical&quot; tracking task for manual control research.
<i>IEEE Transactions on Human Factors in Electronics</i>,
HFE-7(4):138--145, Dec. 1966.
</p>

<p>
J. J. Potter and W. E. Singhose.
Improving manual tracking of systems with oscillatory dynamics.
<i>IEEE Transactions on Human-Machine Systems</i>,
43(1):46--52, Jan. 2013.
</p>

<p>
D. T. McRuer, D. Graham, E. S. Krendel, and W. Reisner.
Human pilot dynamics in compensatory systems.
Technical Report AFFDL-TR-65-15, 
Air Force Flight Dynamics Laboratory,
Wright-Patterson AFB, OH, 1965.
</p>

<p>
F. M. Nieuwenhuizen, P. M. T. Zaal, M. Mulder, M. M. van Paassen, and J. A. Mulder.
Modeling human multichannel perception and control using linear time-invariant models.
<i>Journal of Guidance, Control, and Dynamics</i>, 
31(4):999--1013, Jul.-Aug. 2008.
</p>

<p>
R. S. Shirley and L. R. Young.
Motion cues in man-vehicle control: effects of roll-motion cues on human 
operator's behavior in compensatory systems with disturbance inputs.
<i>IEEE Transactions on Man-Machine Systems</i>, 
9(4):121--128, Dec. 1968.
</p>

<p>
P. M. T. Zaal, D. M. Pool, M. M. van Paassen, and M. Mulder.
Comparing multimodal pilot pitch control behavior between simulated and real flight.
<i>Journal of Guidance, Control, and Dynamics</i>, 
35(5):1456--1471, Sep.-Oct. 2012.
</p>
</html>"));
    end References;
    class Contact "Author contact information"
      extends Modelica.Icons.Contact;
      annotation(preferredView = "info", Documentation(info = "<html>
<dl><dt><b>Author:</b><br></dt>
<dd>James Jackson Potter</dd>
<dd><a href=\"http://www.vttresearch.com\">VTT Technical Research Centre 
of Finland</a></dd>
<dd>Tekniikantie 4 A</dd>
<dd>Otaniemi, Espoo</dd>
<dd>Finland</dd>
<dd>email: <a href=\"mailto:jjpotterkowski@gmail.com\">
jjpotterkowski@gmail.com</a></dd></dl>

<p><b>Acknowledgments:</b></p><ul>
<li>Technical advice related to OMPython and FMUs from A. Ashgar, A. Pop, and 
M. Sj&ouml;lund.
</li>
<li>Financial support from <a href=\"https://fellowship.ercim.eu\">Alain 
Bensoussan post-doctoral fellowship</a> from the
<a href=\"http://www.ercim.eu\">European Research Consortium for Informatics
and Mathematics</a> (ERCIM)</li></ul>
</html>"));
    end Contact;
  end UsersGuide;
  package TrackingTasks "Manual tracking tasks"
    extends Modelica.Icons.Package;
    extends ManualTracking.Icons.TrackingTask;
    model TaskSettings
      extends ManualTracking.Icons.TaskSettings;
      parameter Modelica.SIunits.Time taskDuration = 120 "Duration of tracking task";
      parameter Modelica.SIunits.Time previewTime = 0 "Time in advance to show target motion (for user experiment)";
      parameter Integer backgroundVisible = 0 "Show background hatch marks if 1, do not show if 0 (for user experiment)";
    end TaskSettings;
    model SampleTaskCompensatory "Sample compensatory tracking task"
      extends Modelica.Blocks.Icons.Block;
      extends ManualTracking.Icons.TrackingTask;
      ManualTracking.ManualControllers.Precision2ndOrderNM precision2ndordernm1 annotation(Placement(visible = true, transformation(origin = {-0.00000000000000210942,-0.00000000000000266454}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ControlledElements.VelocityResponse velocityresponse1(K = 1) annotation(Placement(visible = true, transformation(origin = {50,0.000000000000000444089}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.ReferenceSignals.SumOfSinesHz sumofsineshz1(amps = {10.493,0.835,0.735,0.581,0.474,0.366,0.266,0.167,0.071}, freqs = {0.01,0.03,0.05,0.11,0.19,0.33,0.55,0.91,1.49}, phis = {0,0,0,0,0,0,0,0,0}) annotation(Placement(visible = true, transformation(origin = {-50,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.DisturbanceInputs.SumOfSinesHz sumofsineshz2 annotation(Placement(visible = true, transformation(origin = {0,50}, extent = {{-10,-10},{10,10}}, rotation = -90)));
      ManualTracking.TrackingTasks.TaskSettings tasksettings1(taskDuration = 40) annotation(Placement(visible = true, transformation(origin = {-70,70}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(velocityresponse1.y,precision2ndordernm1.y) annotation(Line(points = {{61,0.000000000000000444089},{80.0699,0.000000000000000444089},{80.0699,-39.8601},{0,-39.8601},{0,-13.986},{0,-13.986}}));
      connect(precision2ndordernm1.u,velocityresponse1.u) annotation(Line(points = {{11,-0.00000000000000266454},{38.1119,-0.00000000000000266454},{38.1119,0},{38.1119,0}}));
      connect(sumofsineshz1.y,precision2ndordernm1.r) annotation(Line(points = {{-39,0},{-11.5385,0},{-11.5385,-0.699301},{-11.5385,-0.699301}}));
      connect(sumofsineshz2.y,precision2ndordernm1.w) annotation(Line(points = {{0.000000000000000673533,39},{0.000000000000000673533,12.9371},{-0.699301,12.9371},{-0.699301,12.9371}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
    end SampleTaskCompensatory;
    model SampleTaskPursuitPreview "Sample tracking task for user experiment that includes pursuit information and target preview"
      extends Modelica.Blocks.Icons.Block;
      extends ManualTracking.Icons.TrackingTask;
      ManualTracking.ManualControllers.Precision2ndOrderNM precision2ndordernm1(tau = 0.25) annotation(Placement(visible = true, transformation(origin = {-0.00000000000000210942,-0.00000000000000266454}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ControlledElements.VelocityResponse velocityresponse1(K = 1) annotation(Placement(visible = true, transformation(origin = {50,0.000000000000000444089}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.ReferenceSignals.SumOfSinesHz sumofsineshz1(amps = {10.493,0.835,0.735,0.581,0.474,0.366,0.266,0.167,0.071}, freqs = {0.01,0.03,0.05,0.11,0.19,0.33,0.55,0.91,1.49}, phis = {0,0,0,0,0,0,0,0,0}) annotation(Placement(visible = true, transformation(origin = {-50,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.DisturbanceInputs.SumOfSinesHz sumofsineshz2 annotation(Placement(visible = true, transformation(origin = {0,50}, extent = {{-10,-10},{10,10}}, rotation = -90)));
      ManualTracking.TrackingTasks.TaskSettings tasksettings1(taskDuration = 60, backgroundVisible = 1, previewTime = 1.5) annotation(Placement(visible = true, transformation(origin = {-70,70}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(velocityresponse1.y,precision2ndordernm1.y) annotation(Line(points = {{61,0.000000000000000444089},{80.0699,0.000000000000000444089},{80.0699,-39.8601},{0,-39.8601},{0,-13.986},{0,-13.986}}));
      connect(precision2ndordernm1.u,velocityresponse1.u) annotation(Line(points = {{11,-0.00000000000000266454},{38.1119,-0.00000000000000266454},{38.1119,0},{38.1119,0}}));
      connect(sumofsineshz1.y,precision2ndordernm1.r) annotation(Line(points = {{-39,0},{-11.5385,0},{-11.5385,-0.699301},{-11.5385,-0.699301}}));
      connect(sumofsineshz2.y,precision2ndordernm1.w) annotation(Line(points = {{0.000000000000000673533,39},{0.000000000000000673533,12.9371},{-0.699301,12.9371},{-0.699301,12.9371}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
    end SampleTaskPursuitPreview;
    model NieuwenhuizenEtAl2008 "Tracking task from Nieuwenhuizen et al. (2008) with reference and disturbance forcing functions"
      extends Modelica.Blocks.Icons.Block;
      extends ManualTracking.Icons.TrackingTask;
      ManualTracking.ManualControllers.MultichannelModel multichannelmodel1 annotation(Placement(visible = true, transformation(origin = {-0.00000000000000210942,-0.00000000000000266454}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ControlledElements.AccelerationResponse accelerationresponse1(K = 4) annotation(Placement(visible = true, transformation(origin = {50,0.000000000000000444089}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.ReferenceSignals.SumOfSinesRadPerSec sumofsinesradpersec1(amps = {0.0568,0.0495,0.0397,0.0278,0.0162,0.0078,0.0052,0.0034,0.0024,0.0019,0.0015,0.0014}, freqs = {0.4602,0.6903,0.9971,1.4573,2.2243,3.6049,4.6786,6.366,8.2068,10.661,13.729,16.336}, phis = {0,0,0,0,0,0,0,0,0,0,0,0}) annotation(Placement(visible = true, transformation(origin = {-50,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.DisturbanceInputs.SumOfSinesRadPerSec sumofsinesradpersec2(amps = {0.002,0.0046,0.0074,0.0125,0.0184,0.0235,0.0264,0.0316,0.0382,0.0489,0.0669,0.0848}, freqs = {0.3835,0.6136,0.8437,1.3039,2.1476,3.5282,4.5252,6.2893,8.1301,10.507,13.652,16.183}, phis = {0,0,0,0,0,0,0,0,0,0,0,0}) annotation(Placement(visible = true, transformation(origin = {0,50}, extent = {{-10,-10},{10,10}}, rotation = -90)));
      ManualTracking.TrackingTasks.TaskSettings tasksettings1(taskDuration = 81.92, backgroundVisible = 1) annotation(Placement(visible = true, transformation(origin = {-70,70}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(accelerationresponse1.y,multichannelmodel1.y) annotation(Line(points = {{61,0.000000000000000444089},{80.0699,0.000000000000000444089},{80.0699,-39.8601},{0,-39.8601},{0,-13.986},{0,-13.986}}));
      connect(multichannelmodel1.u,accelerationresponse1.u) annotation(Line(points = {{11,-0.00000000000000266454},{38.1119,-0.00000000000000266454},{38.1119,0},{38.1119,0}}));
      connect(sumofsinesradpersec1.y,multichannelmodel1.r) annotation(Line(points = {{-39,0},{-11.5385,0},{-11.5385,-0.699301},{-11.5385,-0.699301}}));
      connect(sumofsinesradpersec2.y,multichannelmodel1.w) annotation(Line(points = {{0.000000000000000673533,39},{0.000000000000000673533,12.9371},{-0.699301,12.9371},{-0.699301,12.9371}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
    end NieuwenhuizenEtAl2008;
    model PotterSinghose2014 "Tracking task from Potter and Singhose (2014) with undelayed velocity controlled element"
      extends Modelica.Blocks.Icons.Block;
      extends ManualTracking.Icons.TrackingTask;
      ManualTracking.ManualControllers.Precision2ndOrderNM precision2ndordernm1(K = 8, T1 = 3, T2 = 6) annotation(Placement(visible = true, transformation(origin = {-0.00000000000000210942,-0.00000000000000266454}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ControlledElements.VelocityResponse velocityresponse1(K = 0.3396) annotation(Placement(visible = true, transformation(origin = {50,0.000000000000000444089}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.ReferenceSignals.SumOfSinesRadPerSec sumofsinesradpersec1(amps = {0.12,0.256,0.395,0.536,0.688,0.839,1.057,1.198,16.92}, freqs = {9.362,5.718,3.456,2.074,1.194,0.691,0.314,0.189,0.031}, phis = {1.928,0.664,3.719,2.455,0.898,0.341,0.336,4.593,3.367}) annotation(Placement(visible = true, transformation(origin = {-50,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.DisturbanceInputs.SumOfSinesRadPerSec sumofsinesradpersec2 annotation(Placement(visible = true, transformation(origin = {0,50}, extent = {{-10,-10},{10,10}}, rotation = -90)));
      ManualTracking.TrackingTasks.TaskSettings tasksettings1(taskDuration = 100, backgroundVisible = 1) annotation(Placement(visible = true, transformation(origin = {-70,70}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(velocityresponse1.y,precision2ndordernm1.y) annotation(Line(points = {{61,0.000000000000000444089},{80.0699,0.000000000000000444089},{80.0699,-39.8601},{0,-39.8601},{0,-13.986},{0,-13.986}}));
      connect(precision2ndordernm1.u,velocityresponse1.u) annotation(Line(points = {{11,-0.00000000000000266454},{38.1119,-0.00000000000000266454},{38.1119,0},{38.1119,0}}));
      connect(sumofsinesradpersec1.y,precision2ndordernm1.r) annotation(Line(points = {{-39,0},{-11.5385,0},{-11.5385,-0.699301},{-11.5385,-0.699301}}));
      connect(sumofsinesradpersec2.y,precision2ndordernm1.w) annotation(Line(points = {{0.000000000000000673533,39},{0.000000000000000673533,12.9371},{-0.699301,12.9371},{-0.699301,12.9371}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
    end PotterSinghose2014;
    model ZaalEtAl2012 "Tracking task from Zaal et al. (2012) with placeholder controlled element"
      extends Modelica.Blocks.Icons.Block;
      extends ManualTracking.Icons.TrackingTask;
      ManualTracking.ManualControllers.MultimodalModel multimodalmodel1 annotation(Placement(visible = true, transformation(origin = {-0.00000000000000210942,-0.00000000000000266454}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ControlledElements.VelocityResponse velocityresponse1(K = 1) annotation(Placement(visible = true, transformation(origin = {50,0.000000000000000444089}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.ReferenceSignals.SumOfSinesRadPerSec sumofsinesradpersec1(amps = {0.698,0.489,0.22,0.119,0.08,0.049,0.031,0.023,0.018,0.016}, freqs = {0.46,0.997,2.071,3.145,4.065,5.599,7.9,10.661,14.88,17.564}, phis = {1.288,6.089,5.507,1.734,2.019,0.441,5.175,3.415,1.066,3.479}) annotation(Placement(visible = true, transformation(origin = {-50,0}, extent = {{-10,-10},{10,10}}, rotation = 0)));
      ManualTracking.ForcingFunctions.DisturbanceInputs.SumOfSinesRadPerSec sumofsinesradpersec2(amps = {0.026,0.035,0.021,0.017,0.021,0.028,0.028,0.053,0.071,0.109}, freqs = {0.383,0.844,1.764,2.838,3.912,5.446,7.747,10.508,13.116,17.334}, phis = {1.145,5.336,0.802,7.39,8.326,5.398,-1.349,0.128,0.696,0.916}) annotation(Placement(visible = true, transformation(origin = {0,50}, extent = {{-10,-10},{10,10}}, rotation = -90)));
      ManualTracking.TrackingTasks.TaskSettings tasksettings1(taskDuration = 90, backgroundVisible = 1) annotation(Placement(visible = true, transformation(origin = {-70,70}, extent = {{-10,-10},{10,10}}, rotation = 0)));
    equation
      connect(velocityresponse1.y,multimodalmodel1.y) annotation(Line(points = {{61,0.000000000000000444089},{80.0699,0.000000000000000444089},{80.0699,-39.8601},{0,-39.8601},{0,-13.986},{0,-13.986}}));
      connect(multimodalmodel1.u,velocityresponse1.u) annotation(Line(points = {{11,-0.00000000000000266454},{38.1119,-0.00000000000000266454},{38.1119,0},{38.1119,0}}));
      connect(sumofsinesradpersec1.y,multimodalmodel1.r) annotation(Line(points = {{-39,0},{-11.5385,0},{-11.5385,-0.699301},{-11.5385,-0.699301}}));
      connect(sumofsinesradpersec2.y,multimodalmodel1.w) annotation(Line(points = {{0.000000000000000673533,39},{0.000000000000000673533,12.9371},{-0.699301,12.9371},{-0.699301,12.9371}}));
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})));
    end ZaalEtAl2012;
    annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Model-TrackingTask.png\" alt=\"Model-TrackingTask\">
</p>

<p>
A tracking task model should have the standard form shown above, and it should
be stored inside the <i>TrackingTasks</i> package.  It includes one block from
the <i>ForcingFunctions.ReferenceSignals</i>, 
<i>ForcingFunctions.DisturbanceInputs</i>, and 
<i>ControlledElements</i> packages, each connected to the appropriate port of
a <i>ManualController</i> block.   
</p>

<p>
An additional component, the <i>TaskSettings</i> block, must be included.  This
block contains important details of the tracking task: <b>taskDuration</b> is 
the total length of the task; <b>previewTime</b> is the amount of time in advance
to show the target motion; and <b>backgroundVisible</b> determines whether or not 
pursuit (background) information is shown.  The last two parameters are only used
in the user experiment, and not in the parameter tuning or simulation functions.
The <i>TrackingTasks.FromReferences</i> package provides a few manual tracking
tasks from the literature.
</p>
</html>"));
  end TrackingTasks;
  package ManualControllers
    extends Modelica.Icons.Package;
    extends ManualTracking.Icons.Human;
    block DelayedGain
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K = 1 "Proportional gain";
      parameter Real tau = 0.25 "Time delay (s)";
      Modelica.Blocks.Math.Gain gain(k = K);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay(delayTime = tau);
    equation
      e = gain.u;
      connect(gain.y,timedelay.u);
      v = timedelay.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/DelayedGain.png\" alt=\"DelayedGain\">
</p>
</html>"));
    end DelayedGain;
    block DelayedLead
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K = 1 "Proportional gain";
      parameter Real tau = 0.25 "Time delay (s)";
      parameter Real T = 5 "Time constant of phase lead (s)";
      ManualTracking.Blocks.ComplexZero complexzero(k = K, T = T);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay(delayTime = tau);
    equation
      e = complexzero.u;
      connect(complexzero.y,timedelay.u);
      v = timedelay.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/DelayedLead.png\" alt=\"DelayedLead\">
</p>
</html>"));
    end DelayedLead;
    block DelayedLag
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K = 1 "Proportional gain";
      parameter Real tau = 0.25 "Time delay (s)";
      parameter Real T = 5 "Time constant of phase lag (s)";
      Modelica.Blocks.Continuous.FirstOrder firstorder(k = K, T = T);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay(delayTime = tau);
    equation
      e = firstorder.u;
      connect(firstorder.y,timedelay.u);
      v = timedelay.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/DelayedLag.png\" alt=\"DelayedLag\">
</p>
</html>"));
    end DelayedLag;
    block DelayedLeadLag
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K = 1 "Proportional gain";
      parameter Real tau = 0.25 "Time delay (s)";
      parameter Real T1 = 10 "Time constant of phase lead (s)";
      parameter Real T2 = 0.5 "Time constant of phase lag (s)";
      Modelica.Blocks.Math.Gain gain(k = K);
      Modelica.Blocks.Continuous.TransferFunction leadlag(b = {T1,1}, a = {T2,1});
      Modelica.Blocks.Nonlinear.FixedDelay timedelay(delayTime = tau);
    equation
      e = gain.u;
      connect(gain.y,leadlag.u);
      connect(leadlag.y,timedelay.u);
      v = timedelay.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/DelayedLeadLag.png\" alt=\"DelayedLeadLag\">
</p>
</html>"));
    end DelayedLeadLag;
    block Precision1stOrderNM
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K = 1 "Proportional gain";
      parameter Real tau = 0.25 "Time delay (s)";
      parameter Real T1 = 5 "Time constant of phase lead (s)";
      parameter Real T2 = 5 "Time constant of phase lag (s)";
      parameter Real T3 = 5 "Time constant of neuromuscular filter (rad/s)";
      Modelica.Blocks.Math.Gain gain(k = K);
      Modelica.Blocks.Continuous.TransferFunction leadlag(b = {T1,1}, a = {T2,1});
      Modelica.Blocks.Continuous.FirstOrder firstorder(k = 1, T = T3);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay(delayTime = tau);
    equation
      e = gain.u;
      connect(gain.y,leadlag.u);
      connect(leadlag.y,firstorder.u);
      connect(firstorder.y,timedelay.u);
      v = timedelay.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Precision1stOrderNM.png\" alt=\"Precision1stOrderNM\">
</p>
</html>"));
    end Precision1stOrderNM;
    block Precision2ndOrderNM
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K = 1 "Proportional gain";
      parameter Real tau = 0.25 "Time delay (s)";
      parameter Real T1 = 5 "Time constant of phase lead (s)";
      parameter Real T2 = 5 "Time constant of phase lag (s)";
      parameter Real omega = 12 "Natural frequency of neuromuscular filter (rad/s)";
      parameter Real zeta = 0.707 "Damping ratio of neuromuscular filter";
      Modelica.Blocks.Math.Gain gain(k = K);
      Modelica.Blocks.Continuous.TransferFunction leadlag(b = {T1,1}, a = {T2,1});
      Modelica.Blocks.Continuous.SecondOrder secondorder(k = 1, w = omega, D = zeta);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay(delayTime = tau);
    equation
      e = gain.u;
      connect(gain.y,leadlag.u);
      connect(leadlag.y,secondorder.u);
      connect(secondorder.y,timedelay.u);
      v = timedelay.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Precision2ndOrderNM.png\" alt=\"Precision2ndOrderNM\">
</p>
</html>"));
    end Precision2ndOrderNM;
    block Precision3rdOrderNM
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K = 1 "Proportional gain";
      parameter Real tau = 0.25 "Time delay (s)";
      parameter Real T1 = 5 "Time constant of phase lead (s)";
      parameter Real T2 = 5 "Time constant of phase lag (s)";
      parameter Real T3 = 5 "Time constant of neuromuscular filter (rad/s)";
      parameter Real omega = 12 "Natural frequency of neuromuscular filter (rad/s)";
      parameter Real zeta = 0.2 "Damping ratio of neuromuscular filter";
      Modelica.Blocks.Math.Gain gain(k = K);
      Modelica.Blocks.Continuous.TransferFunction leadlag(b = {T1,1}, a = {T2,1});
      Modelica.Blocks.Continuous.FirstOrder firstorder(k = 1, T = T3);
      Modelica.Blocks.Continuous.SecondOrder secondorder(k = 1, w = omega, D = zeta);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay(delayTime = tau);
    equation
      e = gain.u;
      connect(gain.y,leadlag.u);
      connect(leadlag.y,firstorder.u);
      connect(firstorder.y,secondorder.u);
      connect(secondorder.y,timedelay.u);
      v = timedelay.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Precision3rdOrderNM.png\" alt=\"Precision3rdOrderNM\">
</p>
</html>"));
    end Precision3rdOrderNM;
    block PrecisionOriginal
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K = 1 "Proportional gain";
      parameter Real tau = 0.25 "Time delay (s)";
      parameter Real T1 = 5 "Time constant of low-frequency phase lead (s)";
      parameter Real T2 = 5 "Time constant of low-frequency phase lag (s)";
      parameter Real T3 = 5 "Time constant of high-frequency phase lead (s)";
      parameter Real T4 = 5 "Time constant of high-frequency phase lag (s)";
      parameter Real T5 = 5 "Time constant of neuromuscular filter (rad/s)";
      parameter Real omega = 12 "Natural frequency of neuromuscular filter (rad/s)";
      parameter Real zeta = 0.2 "Damping ratio of neuromuscular filter";
      Modelica.Blocks.Math.Gain gain(k = K);
      Modelica.Blocks.Continuous.TransferFunction leadlag1(b = {T1,1}, a = {T2,1});
      Modelica.Blocks.Continuous.TransferFunction leadlag2(b = {T3,1}, a = {T4,1});
      Modelica.Blocks.Continuous.FirstOrder firstorder(k = 1, T = T5);
      Modelica.Blocks.Continuous.SecondOrder secondorder(k = 1, w = omega, D = zeta);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay(delayTime = tau);
    equation
      e = gain.u;
      connect(gain.y,leadlag1.u);
      connect(leadlag1.y,leadlag2.u);
      connect(leadlag2.y,firstorder.u);
      connect(firstorder.y,secondorder.u);
      connect(secondorder.y,timedelay.u);
      v = timedelay.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/PrecisionOriginal.png\" alt=\"PrecisionOriginal\">
</p>
</html>"));
    end PrecisionOriginal;
    block MultichannelModel "Manual controller model from Nieuwenhuizen et al. (2008) with compensatory (visual) and pursuit (vestibular) pathways"
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K1 = 0.17 "Gain of compensatory path";
      parameter Real K2 = 1.59 "Gain of pursuit path";
      parameter Real tau1 = 0.32 "Time delay of compensatory path (s)";
      parameter Real tau2 = 0.29 "Time delay of pursuit path (s)";
      parameter Real T1 = 2.93 "Time constant of compensatory phase lead (s)";
      parameter Real T2 = 0.1 "Time constant of pursuit phase lead (s)";
      parameter Real T3 = 6.0 "Time constant of pursuit phase lag (s)";
      parameter Real omega = 12.0 "Natural frequency of neuromuscular filter (rad/s)";
      parameter Real zeta = 0.3 "Damping ratio of neuromuscular filter";
      ManualTracking.Blocks.ComplexZero complexzero(k = K1, T = T1);
      Modelica.Blocks.Continuous.TransferFunction leadlag(b = {T2,1}, a = {T3,1});
      Modelica.Blocks.Continuous.Derivative derivative1(k = K2);
      Modelica.Blocks.Continuous.Derivative derivative2(k = 1);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay1(delayTime = tau1);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay2(delayTime = tau2);
      Modelica.Blocks.Math.Add add2;
      Modelica.Blocks.Continuous.SecondOrder secondorder(k = 1, w = omega, D = zeta);
    equation
      e = complexzero.u;
      connect(complexzero.y,timedelay1.u);
      connect(timedelay1.y,add2.u1);
      connect(y,derivative1.u);
      connect(derivative1.y,derivative2.u);
      connect(derivative2.y,leadlag.u);
      connect(leadlag.y,timedelay2.u);
      connect(timedelay2.y,add2.u2);
      connect(add2.y,secondorder.u);
      v = secondorder.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/MultiChannelModel.png\" alt=\"MultiChannelModel\">
</p>
</html>"));
    end MultichannelModel;
    block MultimodalModel "Manual controller model from Zaal et al. (2012) with compensatory (visual) and pursuit (vestibular) pathways"
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K1 = 1.1 "Gain of compensatory path";
      parameter Real K2 = 0.22 "Gain of pursuit path";
      parameter Real tau1 = 0.23 "Time delay of compensatory path (s)";
      parameter Real tau2 = 0.095 "Time delay of pursuit path (s)";
      parameter Real T1 = 0.4 "Time constant of compensatory phase lead (s)";
      parameter Real T2 = 0.8 "Time constant of compensatory phase lag (s)";
      parameter Real omega = 9.6 "Natural frequency of neuromuscular filter (rad/s)";
      parameter Real zeta = 0.215 "Damping ratio of neuromuscular filter";
      ManualTracking.Blocks.ComplexZero complexzero(k = K1, T = T1);
      Modelica.Blocks.Continuous.TransferFunction leadlag(b = {T1,1}, a = {T2,1});
      Modelica.Blocks.Continuous.Derivative derivative(k = K2);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay1(delayTime = tau1);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay2(delayTime = tau2);
      Modelica.Blocks.Math.Add add2;
      Modelica.Blocks.Continuous.SecondOrder secondorder(k = 1, w = omega, D = zeta);
    equation
      e = complexzero.u;
      connect(complexzero.y,leadlag.u);
      connect(leadlag.y,timedelay1.u);
      connect(y,derivative.u);
      connect(derivative.y,timedelay2.u);
      connect(timedelay1.y,add2.u1);
      connect(timedelay2.y,add2.u2);
      connect(add2.y,secondorder.u);
      v = secondorder.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/MultimodalModel.png\" alt=\"MultimodalModel\">
</p>
</html>"));
    end MultimodalModel;
    block DescriptiveModel "Manual controller model from Hosman and Stassen (1999) with visual and vestibular pathways"
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K1 = 1 "Gain of compensatory proportional path";
      parameter Real K2 = 1 "Gain of compensatory derivative path";
      parameter Real K3 = 1 "Gain of pursuit derivative path";
      parameter Real K4 = 1 "Gain of pursuit acceleration path";
      parameter Real tau1 = 0.25 "Time delay of compensatory proportional path (s)";
      parameter Real tau2 = 0.25 "Time delay of compensatory derivative path (s)";
      parameter Real tau3 = 0.25 "Time delay of pursuit derivative path (s)";
      parameter Real tau4 = 0.25 "Time delay of combined paths (s)";
      parameter Real T1 = 5 "Time constant of phase lead (s)";
      parameter Real T2 = 5 "Time constant of low-frequency phase lag (s)";
      parameter Real T3 = 5 "Time constant of high-frequency phase lag (s)";
      Modelica.Blocks.Math.Gain gain(k = K1);
      Modelica.Blocks.Continuous.Derivative derivativecompensatory(k = K2);
      Modelica.Blocks.Continuous.Derivative derivativepursuit(k = K3);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay1(delayTime = tau1);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay2(delayTime = tau2);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay3(delayTime = tau3);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay4(delayTime = tau4);
      Modelica.Blocks.Continuous.TransferFunction leadlag1(b = {K4,0}, a = {T2,1});
      Modelica.Blocks.Continuous.TransferFunction leadlag2(b = {T1,1}, a = {T3,1});
      Modelica.Blocks.Math.Add add2compensatory;
      Modelica.Blocks.Math.Add add2pursuit;
      Modelica.Blocks.Math.Add add2combined;
    equation
      e = gain.u;
      e = derivativecompensatory.u;
      connect(gain.y,timedelay1.u);
      connect(timedelay1.y,add2compensatory.u1);
      connect(derivativecompensatory.y,timedelay2.u);
      connect(timedelay2.y,add2compensatory.u2);
      connect(y,derivativepursuit.u);
      connect(derivativepursuit.y,timedelay3.u);
      connect(timedelay3.y,add2pursuit.u1);
      connect(y,leadlag1.u);
      connect(leadlag1.y,leadlag2.u);
      connect(leadlag2.y,add2pursuit.u2);
      connect(add2compensatory.y,add2combined.u1);
      connect(add2pursuit.y,add2combined.u2);
      connect(add2combined.y,timedelay4.u);
      v = timedelay4.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/DescriptiveModel.png\" alt=\"DescriptiveModel\">
</p>
</html>"));
    end DescriptiveModel;
    block StructuralFor1stOrder "Based on Hess structural model for first-order controlled element -- pulsing logic and proportional/derivative input switching are not modeled"
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K1 = 1 "Gain of proportional path";
      parameter Real K2 = 1 "Gain of derivative path";
      parameter Real K3 = 1 "Gain of proprioceptive feedback";
      parameter Real tau1 = 0.25 "Time delay of derivative control path (s)";
      parameter Real tau2 = 0.25 "Time delay of total forward control path (s)";
      parameter Real T = 5 "Time constant of proprioceptive feedback lag (s)";
      parameter Real omega = 12 "Natural frequency of neuromuscular filter (rad/s)";
      parameter Real zeta = 0.2 "Damping ratio of neuromuscular filter";
      Modelica.Blocks.Math.Gain gain(k = K1);
      Modelica.Blocks.Continuous.Derivative derivativecompensatory(k = K2);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay1(delayTime = tau1);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay2(delayTime = tau2);
      Modelica.Blocks.Continuous.TransferFunction derivativelagged(b = {K3,0}, a = {T,1});
      Modelica.Blocks.Continuous.SecondOrder secondorder(k = 1, w = omega, D = zeta);
      Modelica.Blocks.Math.Add add2forwardpaths;
      Modelica.Blocks.Math.Add add2proprioceptive(k2 = -1);
    equation
      e = gain.u;
      e = derivativecompensatory.u;
      connect(gain.y,add2forwardpaths.u1);
      connect(derivativecompensatory.y,timedelay1.u);
      connect(timedelay1.y,add2forwardpaths.u2);
      connect(add2forwardpaths.y,timedelay2.u);
      connect(timedelay2.y,add2proprioceptive.u1);
      connect(add2proprioceptive.y,secondorder.u);
      connect(secondorder.y,derivativelagged.u);
      connect(derivativelagged.y,add2proprioceptive.u2);
      v = secondorder.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/StructuralFor1stOrder.png\" alt=\"StructuralFor1stOrder\">
</p>
</html>"));
    end StructuralFor1stOrder;
    block StructuralFor2ndOrder "Based on Hess structural model for second-order controlled element -- pulsing logic and proportional/derivative input switching are not modeled"
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K1 = 1 "Gain of proportional path";
      parameter Real K2 = 1 "Gain of derivative path";
      parameter Real K3 = 1 "Gain of proprioceptive feedback";
      parameter Real tau1 = 0.25 "Time delay of derivative control path (s)";
      parameter Real tau2 = 0.25 "Time delay of total forward control path (s)";
      parameter Real T1 = 5 "Time constant of first proprioceptive feedback lag (s)";
      parameter Real T2 = 5 "Time constant of second proprioceptive feedback lag (s)";
      parameter Real omega = 12 "Natural frequency of neuromuscular filter (rad/s)";
      parameter Real zeta = 0.2 "Damping ratio of neuromuscular filter";
      Modelica.Blocks.Math.Gain gain(k = K1);
      Modelica.Blocks.Continuous.Derivative derivativecompensatory(k = K2);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay1(delayTime = tau1);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay2(delayTime = tau2);
      Modelica.Blocks.Continuous.TransferFunction derivativelagged(b = {K3,0}, a = {T1 * T2,T1 + T2,1});
      Modelica.Blocks.Continuous.SecondOrder secondorder(k = 1, w = omega, D = zeta);
      Modelica.Blocks.Math.Add add2forwardpaths;
      Modelica.Blocks.Math.Add add2proprioceptive(k2 = -1);
    equation
      e = gain.u;
      e = derivativecompensatory.u;
      connect(gain.y,add2forwardpaths.u1);
      connect(derivativecompensatory.y,timedelay1.u);
      connect(timedelay1.y,add2forwardpaths.u2);
      connect(add2forwardpaths.y,timedelay2.u);
      connect(timedelay2.y,add2proprioceptive.u1);
      connect(add2proprioceptive.y,secondorder.u);
      connect(secondorder.y,derivativelagged.u);
      connect(derivativelagged.y,add2proprioceptive.u2);
      v = secondorder.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/StructuralFor2ndOrder.png\" alt=\"StructuralFor2ndOrder\">
</p>
</html>"));
    end StructuralFor2ndOrder;
    block FeedforwardModel "Manual controller model from Drop et al. (2013) with compensatory and feedforward pathways"
      extends ManualTracking.Blocks.SI3SO;
      extends ManualTracking.Icons.ManualController;
      parameter Real K1 = 1 "Gain of compensatory path";
      parameter Real K2 = 1 "Gain of feedforward path";
      parameter Real tau1 = 0.25 "Time delay of compensatory path (s)";
      parameter Real tau2 = 0.25 "Time delay of feedforward path (s)";
      parameter Real T = 5 "Time constant of first-order lag in feedforward path (s)";
      parameter Real omega = 12 "Natural frequency of neuromuscular filter (rad/s)";
      parameter Real zeta = 0.2 "Damping ratio of neuromuscular filter";
      Modelica.Blocks.Math.Gain gain(k = K1);
      Modelica.Blocks.Continuous.FirstOrder firstorder(k = K2, T = T);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay1(delayTime = tau1);
      Modelica.Blocks.Nonlinear.FixedDelay timedelay2(delayTime = tau2);
      ManualTracking.Blocks.FeedForward feedforward;
      Modelica.Blocks.Continuous.SecondOrder secondorderfilter(k = 1, w = omega, D = zeta);
      Modelica.Blocks.Math.Add add2;
    equation
      e = gain.u;
      connect(gain.y,timedelay1.u);
      connect(timedelay1.y,add2.u1);
      connect(r,firstorder.u);
      connect(firstorder.y,feedforward.u);
      connect(feedforward.y,timedelay2.u);
      connect(timedelay2.y,add2.u2);
      connect(add2.y,secondorderfilter.u);
      v = secondorderfilter.y;
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/FeedforwardModel.png\" alt=\"FeedforwardModel\">
</p>
</html>"));
    end FeedforwardModel;
    annotation(Documentation(info = "<html>
<p>
Human control behavior while tracking an unpredictable signal can be modeled 
using tools and techniques from control theory. These models are generally
either structural or algorithmic in nature.  Structural models use explicit
equations and parameters to model human control pathways and the human's 
resulting input-output response.  Algorithmic models use a more implicit
optimal control formulation, where only the human's total response is computed.
This library includes only structural models.
</p>

<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Block-ManualController.png\" alt=\"Block-ManualController\">
</p>

<p>
Structural manual controller models have taken many forms, but most include
one or more of the control pathways shown in the above figure.  Nearly all 
controllers include the <i>compensatory</i> pathway, which acts on the error 
between the reference and measured state.  Manual tracking experiments that
display only this error, and not the reference and measured states 
independently, are called compensatory tracking tasks.
</p>

<p>
If the reference state and the measured state are displayed to the human,
then they can be used for the <i>feedforward</i> and <i>pursuit</i> control
actions.  The presence of pursuit information does not guarantee pursuit 
control will be used, and the absence of pursuit information does not guarantee
pusuit control will not be used.  The <i>neuromuscular</i> filter accounts
for the lag imposed by limb dynamics and neuromuscular delays.  The human
senses the filtered input using the <i>proprioceptive</i> pathway, and compares
it to the desired input.
</p>

<p>
Once the human's control input is determined, a <i>disturbance input</i> is 
added.  This can be used for a disturbance rejection task, or to add 
<i>remnant</i> to the controller model.  Remnant accounts for the human's
control input that is not predicted by the model.
</p>

<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Table-ManualControllers.png\" alt=\"Table-ManualControllers\">
</p>

<p>
Included manual controller models are shown in the above table.  The model
<i>PrecisionOriginal</i> was proposed by McRuer and his colleagues, and various
simplified versions with one of the lead-lag terms removed have been used since
then.  These versions mainly differ in how they represent the human's 
neuromuscular filter.  The <i>MultimodalModel</i> and <i>DescriptiveModel</i>
both include pursuit control, but they have different ways of organizing the 
human's control pathways.  
</p>

<p>
The <i>FeedforwardModel</i> includes feedfoward control.  For this control
pathway, an inverted model of the plant dynamics is needed, and the controller
automatically uses the block <i>ManualTracking.Blocks.FeedForward</i> for this
purpose.  To change the inverse dynamics block, or to make the controller use a
different block, the Modelica file text must be modified manually.
</p>

<p>
Once the controller is selected, the next task is to choose values for
controller parameters.  In the class definitions of each controller, parameters
have a specified minimum and maximum value.  Whenever possible, these values
are based on experimental data from the literature.  Python tools provided with
the <i>ManualTracking</i> library can help select these values -- they are
selected either to yield optimal tracking performance, or the closest fit to 
experimental control behavior.
</p>
</html>"));
  end ManualControllers;
  package ControlledElements
    extends Modelica.Icons.Package;
    extends ManualTracking.Icons.Cart;
    block PositionResponse
      extends Modelica.Blocks.Interfaces.SISO;
      extends ManualTracking.Icons.ControlledElement;
      parameter Real K = 1 "Position gain";
      Modelica.Blocks.Math.Gain gain(k = K);
    equation
      connect(u,gain.u);
      connect(gain.y,y);
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/PositionResponse.png\" alt=\"PositionResponse\">
</p>
</html>"));
    end PositionResponse;
    block VelocityResponse
      extends Modelica.Blocks.Interfaces.SISO;
      extends ManualTracking.Icons.ControlledElement;
      parameter Real K = 1 "Velocity gain";
      Modelica.Blocks.Continuous.Integrator integrator(k = K);
    equation
      connect(u,integrator.u);
      connect(integrator.y,y);
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/VelocityResponse.png\" alt=\"VelocityResponse\">
</p>
</html>"));
    end VelocityResponse;
    block AccelerationResponse
      extends Modelica.Blocks.Interfaces.SISO;
      extends ManualTracking.Icons.ControlledElement;
      parameter Real K = 1 "Acceleration gain";
      Modelica.Blocks.Continuous.Integrator integrator1(k = K);
      Modelica.Blocks.Continuous.Integrator integrator2(k = 1);
    equation
      connect(u,integrator1.u);
      connect(integrator1.y,integrator2.u);
      connect(integrator2.y,y);
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/AccelerationResponse.png\" alt=\"AccelerationResponse\">
</p>
</html>"));
    end AccelerationResponse;
    block PositionLagged
      extends Modelica.Blocks.Interfaces.SISO;
      extends ManualTracking.Icons.ControlledElement;
      parameter Real K = 1 "Position gain";
      parameter Real T = 1 "Lag time constant (s)";
      Modelica.Blocks.Continuous.FirstOrder firstorder(k = K, T = T);
    equation
      connect(u,firstorder.u);
      connect(firstorder.y,y);
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/PositionLagged.png\" alt=\"PositionLagged\">
</p>
</html>"));
    end PositionLagged;
    block VelocityLagged
      extends Modelica.Blocks.Interfaces.SISO;
      extends ManualTracking.Icons.ControlledElement;
      parameter Real K = 1 "Velocity gain";
      parameter Real T = 1 "Lag time constant (s)";
      Modelica.Blocks.Continuous.FirstOrder firstorder(k = K, T = T);
      Modelica.Blocks.Continuous.Integrator integrator(k = 1);
    equation
      connect(u,firstorder.u);
      connect(firstorder.y,integrator.u);
      connect(integrator.y,y);
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/VelocityLagged.png\" alt=\"VelocityLagged\">
</p>
</html>"));
    end VelocityLagged;
    block AccelerationLagged
      extends Modelica.Blocks.Interfaces.SISO;
      extends ManualTracking.Icons.ControlledElement;
      parameter Real K = 1 "Acceleration gain";
      parameter Real T = 1 "Lag time constant (s)";
      Modelica.Blocks.Continuous.FirstOrder firstorder(k = K, T = T);
      Modelica.Blocks.Continuous.Integrator integrator1(k = 1);
      Modelica.Blocks.Continuous.Integrator integrator2(k = 1);
    equation
      connect(u,firstorder.u);
      connect(firstorder.y,integrator1.u);
      connect(integrator1.y,integrator2.u);
      connect(integrator2.y,y);
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/AccelerationLagged.png\" alt=\"AccelerationLagged\">
</p>
</html>"));
    end AccelerationLagged;
    block FirstOrderDivergent
      extends Modelica.Blocks.Interfaces.SISO;
      extends ManualTracking.Icons.ControlledElement;
      parameter Real K = 1 "Control gain";
      parameter Real T = 1 "Divergent time constant (s)";
      Modelica.Blocks.Continuous.TransferFunction transferfunction(b = {K}, a = {T,-1});
    equation
      connect(u,transferfunction.u);
      connect(transferfunction.y,y);
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/FirstOrderDivergent.png\" alt=\"FirstOrderDivergent\">
</p>
</html>"));
    end FirstOrderDivergent;
    block VelocityFlexibleMode
      extends Modelica.Blocks.Interfaces.SISO;
      extends ManualTracking.Icons.ControlledElement;
      parameter Real K = 1 "Velocity gain";
      parameter Real omega = 5 "Natural frequency of flexible mode (rad/s)";
      parameter Real zeta = 0.1 "Damping ratio of flexible mode";
      Modelica.Blocks.Continuous.SecondOrder secondorder(k = 1, w = omega, D = zeta);
      Modelica.Blocks.Continuous.Derivative derivative(k = K);
    equation
      connect(u,derivative.u);
      connect(derivative.y,secondorder.u);
      connect(secondorder.y,y);
      annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/VelocityFlexibleMode.png\" alt=\"VelocityFlexibleMode\">
</p>
</html>"));
    end VelocityFlexibleMode;
    annotation(Documentation(info = "<html>
<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Diagr-MassiveCart.png\" alt=\"Diagr-MassiveCart\">
</p>

The <i>controlled element</i> is the dynamic response of the cursor to control
input, and it represents the real-world system under human control.  A simple 
mechanical example is shown above.  A rolling cart is attached to ground by a 
damper, and the control input pushes the cart with a force proportional to 
<b>K</b>.  The equivalent controlled-element transfer function is shown in the
right side of the figure.  The cart exhibits a lagged velocity response with
time constant <b>M/b</b> and steady-state velocity <b>K/b</b>.  The units of
these parameters depend on the units chosen for <b>M</b>, <b>b</b>, and 
<b>K</b>.  

<p>
Simple models have been used to capture the primary behavior of certain
degrees of freedom in aircraft, automobiles, and other complicated systems.
Many experiments have used the simplest controlled elements with position,
velocity, and acceleration responses. 
</p>

<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Table-ControlledElements.png\" alt=\"Table-ControlledElements\">
</p>

<p>
All controlled elements included in the library are shown in the above table.
There are the basic position, velocity, and acceleration responses.  There
are also versions of these basic responses with an added first-order lag, 
making them less responsive at first, but eventually reaching the same
steady-state position/velocity/acceleration.
</p>

<p>
The unstable <i>FirstOrderDivergent</i> controlled element was used to 
investigate limitations of a human's effective time delay in Jex et al. (1966).
The <i>VelocityFlexibleMode</i> includes a second order mode that can be 
oscillatory.  This controlled element was studied with relatively high damping
in Shirley and Young (1968), and with very low damping in Potter and Singhose
(2013).
</p>
</html>"));
  end ControlledElements;
  package ForcingFunctions
    extends Modelica.Icons.Package;
    extends ManualTracking.Icons.Sine;
    package ReferenceSignals
      extends Modelica.Icons.Package;
      block SumOfSinesHz "Sum-of-sines reference signal"
        extends Modelica.Blocks.Interfaces.SO;
        extends ManualTracking.Icons.ReferenceSignal;
        parameter Real amps[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave amplitudes";
        parameter Real freqs[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave frequencies";
        parameter Real phis[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave phase angles";
      protected
        Modelica.Blocks.Math.MultiSum sineSummer(nu = size(amps, 1));
        ManualTracking.Blocks.SourceSineHz sineWave[size(amps, 1)](amplitude = amps, freq = freqs, phase = phis);
      equation
        for i in 1:size(amps, 1) loop
        connect(sineWave[i].y,sineSummer.u[i]);

        end for;
        connect(sineSummer.y,y);
      end SumOfSinesHz;
      block SumOfSinesRadPerSec "Sum-of-sines reference signal"
        extends Modelica.Blocks.Interfaces.SO;
        extends ManualTracking.Icons.ReferenceSignal;
        parameter Real amps[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave amplitudes";
        parameter Real freqs[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave frequencies";
        parameter Real phis[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave phase angles";
      protected
        Modelica.Blocks.Math.MultiSum sineSummer(nu = size(amps, 1));
        ManualTracking.Blocks.SourceSineRadPerSec sineWave[size(amps, 1)](amplitude = amps, freq = freqs, phase = phis);
      equation
        for i in 1:size(amps, 1) loop
        connect(sineWave[i].y,sineSummer.u[i]);

        end for;
        connect(sineSummer.y,y);
      end SumOfSinesRadPerSec;
      block Step
        extends Modelica.Blocks.Interfaces.SO;
        Modelica.Blocks.Sources.Step step1(height = 1, startTime = 1);
      equation
        connect(step1.y,y);
      end Step;
    end ReferenceSignals;
    package DisturbanceInputs
      extends Modelica.Icons.Package;
      block SumOfSinesHz "Sum-of-sines reference signal"
        extends Modelica.Blocks.Interfaces.SO;
        extends ManualTracking.Icons.DisturbanceInput;
        parameter Real amps[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave amplitudes";
        parameter Real freqs[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave frequencies";
        parameter Real phis[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave phase angles";
      protected
        Modelica.Blocks.Math.MultiSum sineSummer(nu = size(amps, 1));
        ManualTracking.Blocks.SourceSineHz sineWave[size(amps, 1)](amplitude = amps, freq = freqs, phase = phis);
      equation
        for i in 1:size(amps, 1) loop
        connect(sineWave[i].y,sineSummer.u[i]);

        end for;
        connect(sineSummer.y,y);
      end SumOfSinesHz;
      block SumOfSinesRadPerSec "Sum-of-sines reference signal"
        extends Modelica.Blocks.Interfaces.SO;
        extends ManualTracking.Icons.DisturbanceInput;
        parameter Real amps[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave amplitudes";
        parameter Real freqs[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave frequencies";
        parameter Real phis[:] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} "Sine wave phase angles";
      protected
        Modelica.Blocks.Math.MultiSum sineSummer(nu = size(amps, 1));
        ManualTracking.Blocks.SourceSineRadPerSec sineWave[size(amps, 1)](amplitude = amps, freq = freqs, phase = phis);
      equation
        for i in 1:size(amps, 1) loop
        connect(sineWave[i].y,sineSummer.u[i]);

        end for;
        connect(sineSummer.y,y);
      end SumOfSinesRadPerSec;
    end DisturbanceInputs;
    annotation(Documentation(info = "<html>
<p>
In manual tracking experiments, the target's motion is prescribed by a
<i>forcing function</i>.  This function should appear random to prevent the
operator from predicting future behavior of the target, unless the real-world
control task consists of highly predictable signals.  This library, and much 
of manual control theory, focuses on the tracking of unpredictable signals.  
</p>

<p>
<img width=100% src=\"modelica://ManualTracking/Resources/Images/Time-SummedSines.png\" alt=\"Time-SummedSines\">
</p>

<p>
From past studies, it has been shown that the sum of 5 or more sine waves is 
unpredictable to human operators (McRuer et al., 1965).  An example summed-sine
forcing function is shown above.  The individual sine waves on the left are
combined to yield the more complicated function on the right.
</p>

<p>
This package only includes the summed sine wave signal, which is by far the
most common signal used in manual tracking tasks.  Frequency values can be 
either in units of Hz (with <i>SumOfSinesHz</i>), or radians per second 
(with <i>SumOfSinesRadPerSec</i>).  If the user wishes to make a custom
forcing function for either the reference signal or disturbance input, the 
signal must be contained in one block with a single output, and it must be
stored in the appropriate package.  If these rules are violated, the Python
functions will not be able to parse the text of the tracking task.
</p>
</html>"));
  end ForcingFunctions;
  package Blocks "Miscellaneous supporting blocks"
    extends Modelica.Icons.Package;
    extends ManualTracking.Icons.Blocks;
    block FeedForward "Inverted plant dynamics model used in FeedforwardModel manual controller"
      extends Modelica.Blocks.Interfaces.SISO;
      parameter Real k = 1;
      Modelica.Blocks.Math.Gain controlledElement(k = k);
    equation
      connect(controlledElement.u,u);
      connect(controlledElement.y,y);
    end FeedForward;
    block ComplexZero "Proportional and derivative control action on a signal"
      extends Modelica.Blocks.Interfaces.SISO;
      parameter Real k(min = 0, max = 10) = 1 "Proportional gain";
      parameter Real T(min = 0.1, max = 10) = 5 "Time constant of phase lead (s)";
      Modelica.Blocks.Continuous.Derivative derivative(k = T);
      Modelica.Blocks.Math.Add add2;
      Modelica.Blocks.Math.Gain gain(k = k);
    equation
      connect(u,add2.u1);
      connect(u,derivative.u);
      connect(derivative.y,add2.u2);
      connect(add2.y,gain.u);
      connect(gain.y,y);
    end ComplexZero;
    block Add4 "Output the sum of the four inputs"
      extends Modelica.Blocks.Icons.Block;
      parameter Real k1 = 1;
      parameter Real k2 = 1;
      parameter Real k3 = 1;
      parameter Real k4 = 1;
      Modelica.Blocks.Interfaces.RealInput u1 "Connector 1 of Real input signals" annotation(Placement(transformation(extent = {{-140,40},{-100,80}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u2 "Connector 2 of Real input signals" annotation(Placement(transformation(extent = {{-140,0},{-100,40}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u3 "Connector 3 of Real input signals" annotation(Placement(transformation(extent = {{-140,-40},{-100,0}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u4 "Connector 4 of Real input signals" annotation(Placement(transformation(extent = {{-140,-80},{-100,-40}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signals" annotation(Placement(transformation(extent = {{100,-10},{120,10}}, rotation = 0)));
    equation
      y = k1 * u1 + k2 * u2 + k3 * u3 + k4 * u4;
    end Add4;
    block Add5 "Output the sum of the five inputs"
      extends Modelica.Blocks.Icons.Block;
      parameter Real k1 = 1;
      parameter Real k2 = 1;
      parameter Real k3 = 1;
      parameter Real k4 = 1;
      parameter Real k5 = 1;
      Modelica.Blocks.Interfaces.RealInput u1 "Connector 1 of Real input signals" annotation(Placement(transformation(extent = {{-140,60},{-100,100}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u2 "Connector 2 of Real input signals" annotation(Placement(transformation(extent = {{-140,20},{-100,60}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u3 "Connector 3 of Real input signals" annotation(Placement(transformation(extent = {{-140,-20},{-100,20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u4 "Connector 4 of Real input signals" annotation(Placement(transformation(extent = {{-140,-60},{-100,-20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput u5 "Connector 5 of Real input signals" annotation(Placement(transformation(extent = {{-140,-100},{-100,-60}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealOutput y "Connector of Real output signals" annotation(Placement(transformation(extent = {{100,-10},{120,10}}, rotation = 0)));
    equation
      y = k1 * u1 + k2 * u2 + k3 * u3 + k4 * u4 + k5 * u5;
    end Add5;
    partial block SI3SO "3 Single Input / 1 Single Output continuous control block with manual controller signal names"
      extends Modelica.Blocks.Icons.Block;
      Modelica.Blocks.Interfaces.RealInput r "Reference state" annotation(Placement(transformation(extent = {{-140,-20},{-100,20}}, rotation = 0)));
      Modelica.Blocks.Interfaces.RealInput y "Measured state" annotation(Placement(transformation(origin = {0,-120}, extent = {{20,-20},{-20,20}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealInput w "Disturbance input" annotation(Placement(transformation(origin = {0,120}, extent = {{-20,-20},{20,20}}, rotation = 270)));
      Modelica.Blocks.Interfaces.RealOutput u "Control input" annotation(Placement(transformation(extent = {{100,-10},{120,10}}, rotation = 0)));
      Real e "Difference between reference and measured states";
      Real v "Control input before disturbance input is added";
    equation
      e = r - y;
      u = v + w;
    end SI3SO;
    block SourceSineHz
      extends Modelica.Blocks.Interfaces.SO;
      parameter Real amplitude = 1 "Amplitude of sine wave";
      parameter Real freq = 1 "Frequency of sine wave";
      parameter Real phase = 0 "Phase of sine wave";
    protected
      constant Real pi = Modelica.Constants.pi;
    equation
      y = amplitude * Modelica.Math.sin(2 * pi * (freq * time + phase));
    end SourceSineHz;
    block SourceSineRadPerSec
      extends Modelica.Blocks.Interfaces.SO;
      parameter Real amplitude = 1 "Amplitude of sine wave";
      parameter Real freq = 1 "Frequency of sine wave";
      parameter Real phase = 0 "Phase of sine wave";
    equation
      y = amplitude * Modelica.Math.sin(freq * time + phase);
    end SourceSineRadPerSec;
  end Blocks;
  package Icons "Icons package"
    extends Modelica.Icons.Package;
    extends ManualTracking.Icons.IconsMSL;
    partial block ManualController
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-60,0}, extent = {{-30,30},{30,-30}}, textString = "r(t)"),Text(origin = {0,60}, extent = {{-30,30},{30,-30}}, textString = "w(t)"),Text(origin = {60,0}, extent = {{-30,30},{30,-30}}, textString = "u(t)"),Text(origin = {0,-60}, extent = {{-30,30},{30,-30}}, textString = "y(t)")}));
    end ManualController;
    partial block ControlledElement
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {-60,0}, extent = {{-30,30},{30,-30}}, textString = "u(t)"),Text(origin = {60,0}, extent = {{-30,30},{30,-30}}, textString = "y(t)")}));
    end ControlledElement;
    partial block ReferenceSignal
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {60,0}, extent = {{-30,30},{30,-30}}, textString = "r(t)")}));
    end ReferenceSignal;
    partial block DisturbanceInput
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Text(origin = {60,0}, extent = {{-30,30},{30,-30}}, textString = "w(t)")}));
    end DisturbanceInput;
    partial block TaskSettings
      annotation(Icon(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}}), graphics = {Polygon(origin = {1.3835,-4.1418}, rotation = 45.0, fillColor = {64,64,64}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.0,93.333},{-15.0,68.333},{0.0,58.333},{15.0,68.333},{15.0,93.333},{20.0,93.333},{25.0,83.333},{25.0,58.333},{10.0,43.333},{10.0,-41.667},{25.0,-56.667},{25.0,-76.667},{10.0,-91.667},{0.0,-91.667},{0.0,-81.667},{5.0,-81.667},{15.0,-71.667},{15.0,-61.667},{5.0,-51.667},{-5.0,-51.667},{-15.0,-61.667},{-15.0,-71.667},{-5.0,-81.667},{0.0,-81.667},{0.0,-91.667},{-10.0,-91.667},{-25.0,-76.667},{-25.0,-56.667},{-10.0,-41.667},{-10.0,43.333},{-25.0,58.333},{-25.0,83.333},{-20.0,93.333}}),Polygon(origin = {10.1018,5.218}, rotation = -45.0, fillColor = {255,255,255}, fillPattern = FillPattern.Solid, points = {{-15.0,87.273},{15.0,87.273},{20.0,82.273},{20.0,27.273},{10.0,17.273},{10.0,7.273},{20.0,2.273},{20.0,-2.727},{5.0,-2.727},{5.0,-77.727},{10.0,-87.727},{5.0,-112.727},{-5.0,-112.727},{-10.0,-87.727},{-5.0,-77.727},{-5.0,-2.727},{-20.0,-2.727},{-20.0,2.273},{-10.0,7.273},{-10.0,17.273},{-20.0,27.273},{-20.0,82.273}})}));
    end TaskSettings;
    partial class TrackingTask
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(origin = {-39.4847,6.14035}, fillColor = {255,255,255}, extent = {{-20,-20},{20,20}}),Rectangle(origin = {40.5153,6.14035}, fillColor = {255,255,255}, extent = {{-20,-20},{20,20}}),Polygon(origin = {10.5153,6.14035}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10,0},{-5,5},{-5,-5},{10,0}}),Polygon(origin = {-39.4847,-23.8596}, rotation = 270, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10,0},{5,5},{5,-5},{-10,0}}),Polygon(origin = {-69.4847,6.14035}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10,0},{-5,5},{-5,-5},{10,0}}),Line(origin = {-79.4847,6.14035}, points = {{20,0},{-20,0}}),Line(origin = {0.515254,6.14035}, points = {{20,0},{-20,0}}),Line(origin = {0.252154,-33.4795}, points = {{39.6199,19.4444},{39.6199,-19.4444},{-39.6199,-19.4444},{-39.6199,17.9825}}),Line(origin = {-59.1923,26.1404}, points = {{20,0},{20.0585,31.8713}}),Polygon(origin = {-38.9584,36.0819}, rotation = 270, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10,0},{-5,5},{-5,-5},{10,0}})}));
    end TrackingTask;
    partial class Blocks
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Rectangle(extent = {{-40,40},{40,-40}}),Polygon(origin = {-50,0}, fillPattern = FillPattern.Solid, points = {{10,0},{-5,5},{-5,-5},{10,0}}),Line(origin = {-50,0}, points = {{-30,0},{0,0}}),Line(origin = {70.0939,0.516432}, points = {{-30,0},{0,0}}),Polygon(origin = {70.0939,0.516432}, fillPattern = FillPattern.Solid, points = {{10,0},{-5,5},{-5,-5},{10,0}})}));
    end Blocks;
    partial class BlocksMSL
      annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100.0,-100.0},{100.0,100.0}}, initialScale = 0.1), graphics = {Rectangle(origin = {0.0,35.1488}, fillColor = {255,255,255}, extent = {{-30.0,-20.1488},{30.0,20.1488}}),Rectangle(origin = {0.0,-34.8512}, fillColor = {255,255,255}, extent = {{-30.0,-20.1488},{30.0,20.1488}}),Line(origin = {-51.25,0.0}, points = {{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),Polygon(origin = {-40.0,35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),Line(origin = {51.25,0.0}, points = {{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),Polygon(origin = {40.0,-35.0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}));
    end BlocksMSL;
    partial class Sine
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Line(points = {{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, smooth = Smooth.Bezier)}));
    end Sine;
    partial class Cart
      annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Line(origin = {0.292398,16.0819}, points = {{-80,-40},{80,-40}}),Line(origin = {0.292398,16.0819}, points = {{80,-40},{40,-80}}),Line(origin = {0.292398,16.0819}, points = {{40,-40},{0,-80}}),Line(origin = {0.292398,16.0819}, points = {{0,-40},{-40,-80}}),Line(origin = {0.292398,16.0819}, points = {{-40,-40},{-80,-80}}),Ellipse(origin = {13.4503,-12.8655}, extent = {{-10,10},{10,-10}}, endAngle = 360),Ellipse(origin = {51.7544,-12.7193}, extent = {{-10,10},{10,-10}}, endAngle = 360),Rectangle(origin = {33.0409,28.3626}, extent = {{-30,30},{30,-30}}),Polygon(origin = {-38.3062,29.2396}, fillColor = {0,0,0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-40.9336,9.94164},{12.8676,9.94164},{12.8676,27.1931},{41.2302,-0.877072},{12.8676,-28.9472},{12.8676,-11.4034},{-40.9336,-11.4034},{-40.9336,9.94164}})}));
    end Cart;
    partial class Human
      annotation(Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2})), Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2,2}), graphics = {Ellipse(origin = {0,60}, extent = {{-20,20},{20,-20}}, endAngle = 360),Line(origin = {0.292398,10.0877}, points = {{0,28.8012},{0,-28.8012}}),Line(origin = {-16.2341,-47.813}, points = {{16.5265,29.392},{-4.81853,-29.6723},{-16.8068,-29.6723}}),Line(origin = {15.9462,-47.9637}, points = {{-15.3614,29.5427},{5.10644,-29.814},{15.6328,-29.814}}),Line(origin = {16.0819,15.2047}, points = {{-15.7895,23.9766},{15.7895,-23.9766}}),Line(origin = {-14.5029,-32.924}, points = {{-15.7895,23.9766},{14.9123,71.6374}})}));
    end Human;
    partial class IconsMSL
      annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Polygon(origin = {-8.167,-17}, fillColor = {0,0,0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,-50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}}, smooth = Smooth.Bezier, lineColor = {0,0,0}),Ellipse(origin = {-0.5,56.5}, fillColor = {0,0,0}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-12.5,-12.5},{12.5,12.5}}, lineColor = {0,0,0})}));
    end IconsMSL;
  end Icons;
  annotation(Documentation(info = "<html>
<p>
Copyright &copy; 2014-2015, James Jackson Potter.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>"));
end ManualTracking;

