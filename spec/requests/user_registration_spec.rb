require 'spec_helper'

describe 'User Registration' do
  context 'with valid params' do
    it 'succeeds' do
      visit '/auth/register'
    end
  end
  context 'with invalid params' do
    it 'fails' do
      visit '/auth/register'
    end
  end
end
