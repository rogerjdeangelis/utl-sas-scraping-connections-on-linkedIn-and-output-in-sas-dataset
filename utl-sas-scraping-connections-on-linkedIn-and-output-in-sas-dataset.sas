%let pgm=utl-sas-scraping-connections-on-linkedIn-and-output-in-sas-dataset;

SAS scraping all your connections on linkedIn and output sas dataset

SAS have a very poerfull input statement.

Works best in the 1980's classic editor?

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

Go to my network connections and make all connections visible then highlight select
all of them and copy into the paste buffer cntl-c.
You may have to click on 'more' several times.
I was able to copy all my 700+ connections over 6000 lines.

Paste into classic editor and add parmcards see below

 /*----                                                                   ----*/
 /*----  Sample of just two connections                                   ----*/
 /*----  This saves all your connections in file c:/temp/connections.txt  ----*/
 /*----                                                                   ----*/

filename ft15f001 "c:/temp/connections.txt";
parmcards4;
Jane Doe
Member’s name
Jane Doe
Member’s occupation
SAS Infrastructure Macro Developer / Consultant
Connected 5 months ago

Message

John Doe is reachable
Member’s name
John Doe
Member’s occupation
Sr Dir, Statistical Programming, Gilead Sciences
Connected 5 months ago
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  c:/temp/connections.txt  (sixpack of records repeat forever)                                                          */
/*                                                                                                                        */
/*  Jane Doe                                                                                                              */
/*  Member’s name                                                                                                         */
/*  Jane Doe                                                                                                              */
/*  Member’s occupation                                                                                                   */
/*  SAS Infrastructure Macro Developer / Consultant                                                                       */
/*  Connected 5 months ago                                                                                                */
/*                                                                                                                        */
/*  Message                                                                                                               */
/*                                                                                                                        */
/*  John Doe is reachable                                                                                                 */
/*  Member’s name                                                                                                         */
/*  John Doe                                                                                                              */
/*  Member’s occupation                                                                                                   */
/*  Sr Dir, Statistical Programming, Gilead Sciences                                                                      */
/*  Connected 5 months ago                                                                                                */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|


/*----                                                                   ----*/
/*---- First pase get rid of redundant information                       ----*/
/*---- Note compressing mutiple blanks is important                      ----*/
/*----                                                                   ----*/
data _null_;
  infile "c:/temp/connections.txt";
   file "c:/temp/conn1.txt";
  input;
  if not missing(_infile_);
  if _infile_ =: "Member’s" then delete;
  if _infile_ =: "Message" then delete;
  if _infile_ =: "Connected" then delete;
  _infile_=compbl(_infile_);
  put _infile_;
run;quit;

/*----                                                                   ----*/
/*---- Note there are only three usfull records                          ----*/
/*----                                                                   ----*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/* c:/temp/conn1.txt                                                                                                      */
/*                                                                                                                        */
/*  Jane Doe                                                                                                              */
/*  Jane Doe                                                                                                              */
/*  SAS Infrastructure Macro Developer / Consultant                                                                       */
/*  John Doe is reachable                                                                                                 */
/*  John Doe                                                                                                              */
/*  Sr Dir, Statistical Programming, Gilead Sciences                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

data want;
  informat status name occup $300.;
  infile "c:/temp/conn1.txt" missover length=l;
  input #1 status & #2 name & #3 occup &;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  WANT total obs=2                                                                                                      */
/*                                                                                                                        */
/* obs    STATUS                     NAME                           OCCUP                                                 */
/*                                                                                                                        */
/*  1     Jane Doe                 Jane Doe    SAS Infrastructure Macro Developer / Consultant                            */
/*  2     John Doe is reachable    John Doe    Sr Dir, Statistical Programming, Gilead Sciences                           */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
