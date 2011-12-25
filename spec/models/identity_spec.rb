require 'spec_helper'

describe Identity do
  let!(:identity) { Fabricate(:identity) }

  it_behaves_like 'identity'
end
