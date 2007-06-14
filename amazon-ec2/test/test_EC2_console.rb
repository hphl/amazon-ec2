# Amazon Web Services EC2 Query API Ruby library
#
# Ruby Gem Name::  amazon-ec2
# Author::    Glenn Rempe  (mailto:glenn@elasticworkbench.com)
# Copyright:: Copyright (c) 2007 Elastic Workbench, LLC
# License::   Distributes under the same terms as Ruby
# Home::      http://amazon-ec2.rubyforge.org
#++

require File.dirname(__FILE__) + '/test_helper.rb'

context "The EC2 console " do
  
  setup do
    @ec2 = EC2::AWSAuthConnection.new( :access_key_id => "not a key", :secret_access_key => "not a secret" )
    
    @get_console_output_response_body = <<-RESPONSE
    <GetConsoleOutputResponse xmlns="http://ec2.amazonaws.com/doc/2007-01-19">
      <instanceId>i-28a64341</instanceId>
      <timestamp>2007-01-03 15:00:00</timestamp>
      <output>
        YyB2ZXJzaW9uIDQuMC4xIDIwMDUwNzI3IChSZWQgSGF0IDQuMC4xLTUpKSAjMSBTTVAgVGh1IE9j 
        dCAyNiAwODo0MToyNiBTQVNUIDIwMDYKQklPUy1wcm92aWRlZCBwaHlzaWNhbCBSQU0gbWFwOgpY 
        ZW46IDAwMDAwMDAwMDAwMDAwMDAgLSAwMDAwMDAwMDZhNDAwMDAwICh1c2FibGUpCjk4ME1CIEhJ 
        R0hNRU0gYXZhaWxhYmxlLgo3MjdNQiBMT1dNRU0gYXZhaWxhYmxlLgpOWCAoRXhlY3V0ZSBEaXNh 
        YmxlKSBwcm90ZWN0aW9uOiBhY3RpdmUKSVJRIGxvY2t1cCBkZXRlY3Rpb24gZGlzYWJsZWQKQnVp 
        bHQgMSB6b25lbGlzdHMKS2VybmVsIGNvbW1hbmQgbGluZTogcm9vdD0vZGV2L3NkYTEgcm8gNApF 
        bmFibGluZyBmYXN0IEZQVSBzYXZlIGFuZCByZXN0b3JlLi4uIGRvbmUuCg==
        </output>
    </GetConsoleOutputResponse>
    RESPONSE
    
  end
  
  
  specify "should return info written to a specific instances console" do
    @ec2.stubs(:make_request).with('GetConsoleOutput', {"instanceId"=>"i-2ea64347"}).
       returns stub(:body => @get_console_output_response_body, :is_a? => true)
    @ec2.get_console_output( :instance_id => "i-2ea64347" ).should.be.an.instance_of EC2::Response
    response = @ec2.get_console_output( :instance_id => "i-2ea64347" )
    response.instanceId.should.equal "i-28a64341"
    response.timestamp.should.equal "2007-01-03 15:00:00"
  end
  
  
  specify "method get_console_output should raise an exception when called without nil/empty string arguments" do
    lambda { @ec2.get_console_output() }.should.raise(EC2::ArgumentError)
    lambda { @ec2.get_console_output(:instance_id => nil) }.should.raise(EC2::ArgumentError)
    lambda { @ec2.get_console_output(:instance_id => "") }.should.raise(EC2::ArgumentError)
  end
  
  
end