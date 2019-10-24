# encoding: utf-8
#

known_exception_accounts = attribute(
  'known_exception_accounts',
  description: 'Accounts that granted policy exceptions (Array)',
  value: ['root']
)

control "V-71931" do
  title "Existing passwords must be restricted to a 60-day maximum lifetime."
  desc  "Any password, no matter how complex, can eventually be cracked.
Therefore, passwords need to be changed periodically. If the operating system
does not limit the lifetime of passwords and force users to change their
passwords, there is the risk that the operating system passwords could be
compromised."
  impact 0.5
  tag "gtitle": "SRG-OS-000076-GPOS-00044"
  tag "gid": "V-71931"
  tag "rid": "SV-86555r1_rule"
  tag "stig_id": "RHEL-07-010260"
  tag "cci": ["CCI-000199"]
  tag "documentable": false
  tag "nist": ["IA-5 (1) (d)", "Rev_4"]
  tag "subsystems": ['password', '/etc/shadow']
  desc "check", "Check whether the maximum time period for existing passwords is
restricted to 60 days.

# awk -F: '$5 > 60 {print $1}' /etc/shadow

If any results are returned that are not associated with a system account, this
is a finding."
  desc "fix", "Configure non-compliant accounts to enforce a 60-day maximum
password lifetime restriction.

# chage -M 60 [user]"
  tag "fix_id": "F-78283r1_fix"
  test_run = false
  shadow.users.each do |user|
    # filtering on non-system accounts (uid >= 1000)
    if !user.nil? && !user(user).uid.nil?
      next unless user(user).uid >= 1000
      if !known_exception_accounts.nil?
        next if known_exception_accounts.include?("#{user}")
      end
      test_run = true
      describe shadow.users(user) do
      its('max_days.first.to_i') { should cmp <= 60 }
      end
    end
  end

  if !test_run
    describe "This control skipped. No users found to test. All skipped based on 'known_exception_accounts' settings or UID >= 1000" do
      skip "This control skipped. No users found to test. All skipped based on 'known_exception_accounts' settings or UID >= 1000"
    end
  end
end
