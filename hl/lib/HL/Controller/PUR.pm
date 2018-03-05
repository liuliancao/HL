package HL::Controller::Pur;
use Mojo::Base 'Mojolicious::Controller';

sub create { shift->render(pur => {}) }

sub edit {
  my $self = shift;
  $self->render(pur => $self->purs->find($self->param('id')));
}

sub index {
  my $self = shift;
  $self->render(purs => $self->purs->all);
}

sub list {
  my $self = shift;
  $self->render(purs => $self->purs->all);
}

sub remove {
  my $self = shift;
  $self->purs->remove($self->param('id'));
  $self->redirect_to('pur');
}

sub show {
  my $self = shift;
  $self->render(pur => $self->purs->find($self->param('id')));
}

sub store {
  my $self = shift;

  my $validation = $self->_validation;
  return $self->render(action => 'create', pur => {})
    if $validation->has_error;

  my $id = $self->purs->add($validation->output);
  $self->redirect_to('show_pur', id => $id);
}

sub search {
}



sub update {
  my $self = shift;

  my $validation = $self->_edit_validation;
  return $self->render(action => 'edit', pur => {}) if $validation->has_error;

  my $id = $self->param('id');
  $self->purs->save($id, $validation->output);
  $self->redirect_to('show_pur', id => $id);
}

sub _validation {
  my $self = shift;

  my $validation = $self->validation;
  $validation->required('cost_center');
  $validation->required('department');
  $validation->required('assets');
  $validation->required('q_version');
  $validation->required('applicant');
  $validation->required('pur_type');
  $validation->required('allocation');
  $validation->required('brand');
  $validation->required('pur_number');
  $validation->required('idc_room');
  $validation->required('pur_reason');
  $validation->required('state');
  $validation->required('remarks');

  return $validation;
}

sub _edit_validation {
  my $self = shift;

  my $validation = $self->validation;
  $validation->required('cost_center');
  $validation->required('department');
  $validation->required('assets');
  $validation->required('q_version');
  $validation->required('applicant');
  $validation->required('pur_type');
  $validation->required('allocation');
  $validation->required('brand');
  $validation->required('pur_number');
  $validation->required('idc_room');
  $validation->required('pur_reason');
  $validation->required('state');
  $validation->required('remarks');
  return $validation;
}

1;
