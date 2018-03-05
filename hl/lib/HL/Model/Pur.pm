package HL::Model::Pur;
use Mojo::Base -base;

has 'pg';

sub add {
  my ($self, $pur) = @_;
  return $self->pg->db->insert('pur', $pur, {returning => 'id'})->hash->{id};
}

sub all { shift->pg->db->select('pur')->hashes->to_array }

sub find {
  my ($self, $id) = @_;
  return $self->pg->db->select('pur', '*', {id => $id})->hash;
}

sub remove {
  my ($self, $id) = @_;
  $self->pg->db->delete('pur', {id => $id});
}

sub save {
  my ($self, $id, $pur) = @_;
  $self->pg->db->update('pur', $pur, {id => $id});
}

1;

