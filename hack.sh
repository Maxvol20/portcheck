echo "hack.sh script By Jarlold"

# Check if lolcat is installed in order to give the logo
# that 2009-console-program look
if ! command -v lolcat &> /dev/null
then
   echo "     _                _          _       
    | |              | |        | |     
    | |__   __ _  ___| | __  ___| |__   
    | '_ \\ / _\` |/ __| |/ / / __| \'_ \  
    | | | | (_| | (__|   < _\\__ \\ | | | 
    |_| |_|\\__,_|\___|_|\\_(_)___/_| |_| 
    automatic script kiddie by Jarlold"
else
   echo "     _                _          _       
    | |              | |        | |     
    | |__   __ _  ___| | __  ___| |__   
    | '_ \\ / _\` |/ __| |/ / / __| \'_ \  
    | | | | (_| | (__|   < _\\__ \\ | | | 
    |_| |_|\\__,_|\___|_|\\_(_)___/_| |_| 
    automatic script kiddie by Jarlold" | lolcat
fi

# Check for
# -> Nmap vulners scan
# -> put the CVEs into metasploit
#    --> bring up CVEs (selector menu?)
# -> put the CVEs into exploit_db command
#    --> bring up CVEs  (selector menu?)
# -> If port 80
#    --> run SQLMap
#    --> run wordpress hack
#    --> detect router page?
#        --> run router default logins
#    --> detect login page
#        --> offer to skip process
#        --> run default logins
# -> If SSH
#    --> Try default SSH logins
# -> If FTP
#    --> Try default FTP logins
# -> If SQL
#    --> Try default SQL logins



# Uses the nmap "vulners.nse" vulnerability detection script
echo "Doing nmap vulnerability scan..."
scan1=$(nmap -sV --script vulners $1)


# Find and count the number of CVEs
CVEs=$(echo ${scan1}  | grep --only-matching 'CVE-....-.....') # not sure if this counts *ever* CVE format
NumCVEs=$(echo ${CVEs} | grep --only-matching "CVE" | wc -l)
echo "  --> found ${NumCVEs} CVEs"


# make sure the user has started msfrpcd
echo "Make sure msfrpcd is started, and is using the password specified"
echo "if you don't know how to start it, or the password isn't right, just run"
echo "msfrpcd -P hacksh1337 -S in a different terminal window, and leave it open"
echo

# Runs a Python script to search for CVEs from Metasploit Framework
echo "Searching Metasploit framework for CVE scripts..."
python2 msf_cve_search.py $CVEs
echo 

# searchsploit doesn't like to play well with vulners.nse's output 
echo "Doing a less verbose nmap scan..."
scan2=$(nmap -sV $1 -oX scan2.xml)


# Searches exploitdb for exploits based off of the second nmap scan
# As of now the user is left to sift through these themselves, since
# the formatting and accesibility of these exploits is inconsistent
# and executing them can offer a security risk for the attacker
echo "Searching searchsploit with non-verbose nmap scan..."
echo "Results:"
searchsploit --nmap scan2.xml 
echo










