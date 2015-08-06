require 'spec_helper'

describe 'fooacl::conf' do

  let :facts do {
    :concat_basedir => '/foo',
  } end

  let :title do
    '/tmp/test.acl'
  end

  context 'with an array as permissions' do
    let :params do {
      'permissions' => ['user:myuser:rwx', 'group:mygroup:rwx'],
    } end
    it { should contain_concat__fragment(title) }
  end
  context 'with an multiline-string as permissions' do
    let :params do {
      'permissions' => ["user:myuser:rwx\ngroup:mygroup:rwx"]
    } end
    it { should contain_concat__fragment(title) }
  end
  context 'with an multiline-string that ends with a new line as permissions' do
    let :params do {
      'permissions' => ["user:myuser:rwx\ngroup:mygroup:rwx\n"]
    } end
    it { should contain_concat__fragment(title) }
  end
  context 'with a string as permissions' do
    let :params do {
      'permissions' => 'group:mygroup:rwx',
    } end
    it { should contain_concat__fragment(title) }
  end
end

