LAB 7 GR A Zad 1 - 21 min Zad 2 - 24 min
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <float.h>
#include <assert.h>
#include <stdlib.h>
#include <time.h>
#include <errno.h>
#define SIZE 20
struct pomiar {
	unsigned int nr_pomiaru;
	unsigned int nr_czujnika;
	char data_i_czas[20];
	double temp;
	struct pomiar *nast;
	struct pomiar *poprz;
};
struct d_pomiar {
	struct pomiar* g1, *g2, *g3, *g4;
};
struct pomiar* znajdz_max(struct pomiar* glowa) {
	struct pomiar* pom = glowa, *max = glowa, *pmax = NULL;
	while (pom->nast != NULL) {
		if (pom->nast->temp > max->temp) { max = pom->nast; pmax = pom; }
		pom = pom->nast;
	}
	return max;
}
struct pomiar* znajdz_min(struct pomiar* glowa) {
	struct pomiar* pom = glowa, *min = glowa, *pmin = NULL;
	while (pom->nast != NULL) {
		if (pom->nast->temp < min->temp) { min = pom->nast; pmin = pom; }
		pom = pom->nast;
	}
	return min;
}
struct pomiar* wczytaj(char *fname) { //zal. rekordy koncza sie znakiem CL RF
	FILE *in = fopen(fname, "r");
	if (in == NULL) { printf("\nnie znaleziono pliku we"); exit(0); }
	struct pomiar buf = { 0 };
	struct pomiar* glowa = NULL; struct pomiar* ogon = NULL;
	fscanf(in, "%d", &buf.nr_pomiaru);
	fscanf(in, "%d", &buf.nr_czujnika);
	fscanf(in, "%s", &buf.data_i_czas);
	fscanf(in, "%lf", &buf.temp);
	while (!feof(in)) {
		if (glowa == NULL) {
			glowa = (struct pomiar*)malloc(sizeof(struct pomiar));
			glowa->nr_pomiaru = buf.nr_pomiaru;
			glowa->nr_czujnika = buf.nr_czujnika;
			strcpy(glowa->data_i_czas, buf.data_i_czas);
			glowa->temp = buf.temp;
			glowa->nast = NULL;
			glowa->poprz = NULL;
			ogon = glowa;
		}
		else {
			ogon->nast = (struct pomiar*)malloc(sizeof(struct pomiar));
			ogon->nast->poprz = ogon;
			ogon = ogon->nast;
			ogon->nr_pomiaru = buf.nr_pomiaru;
			ogon->nr_czujnika = buf.nr_czujnika;
			strcpy(ogon->data_i_czas, buf.data_i_czas);
			ogon->temp = buf.temp;
			ogon->nast = NULL;
		}
		fscanf(in, "%d", &buf.nr_pomiaru);
		fscanf(in, "%d", &buf.nr_czujnika);
		fscanf(in, "%s", &buf.data_i_czas);
		fscanf(in, "%lf", &buf.temp);
	}
	fclose(in);
	return glowa;
}
void druga(struct pomiar* glowa) {
	struct pomiar* g1 = NULL, *o1 = NULL; int il1 = 0;//glowa ogon ilosc
	struct pomiar* g2 = NULL, *o2 = NULL; int il2 = 0;
	struct pomiar* g3 = NULL, *o3 = NULL; int il3 = 0;
	struct pomiar* g4 = NULL, *o4 = NULL; int il4 = 0;
	struct pomiar* el = glowa;
	while (el!= NULL) {
		if(el==glowa){ printf("%d %d %s %lf\n", el->nr_pomiaru,el->nr_czujnika, el->data_i_czas, el->temp); }
		if(el->nast == NULL){ printf("%d %d %s %lf\n", el->nr_pomiaru, el->nr_czujnika, el->data_i_czas, el->temp); }
		if(el->nast != NULL && el->nast->nast ==NULL){ printf("%d %d %s %lf\n", el->nr_pomiaru, el->nr_czujnika, el->data_i_czas, el->temp); }
		switch (el->nr_czujnika)
		{
		case 1:
			il1++;
			break;
		case 2:
			il2++;
			break;
		case 3:
			il3++;
			break;
		case 4:
			il4++;
			break;
		}
		el = el->nast;
	}
	printf("\nIlosc czujnika nr1: %d", il1);
	printf("\nIlosc czujnika nr2: %d", il2);
	printf("\nIlosc czujnika nr3: %d", il3);
	printf("\nIlosc czujnika nr4: %d", il4);

}
struct d_pomiar trzecia(struct pomiar *glowa) {
	struct d_pomiar d = { 0 };
	struct pomiar* g1 = NULL, *o1 = NULL;//glowa ogon ilosc
	struct pomiar* g2 = NULL, *o2 = NULL;
	struct pomiar* g3 = NULL, *o3 = NULL;
	struct pomiar* g4 = NULL, *o4 = NULL;
	struct pomiar* el = glowa;
	while (el != NULL) {		
		switch (el->nr_czujnika)
		{
		case 1:
			if (g1 == NULL) {
				g1 = (struct pomiar*)malloc(sizeof(struct pomiar));
				o1 = g1;
				o1->nr_pomiaru = el->nr_pomiaru;
				o1->nr_czujnika = el->nr_czujnika;
				strcpy(o1->data_i_czas, el->data_i_czas);
				o1->temp = el->temp;
				o1->nast = NULL;
				o1->poprz = NULL;				
			}
			else {
				o1->nast = (struct pomiar*)malloc(sizeof(struct pomiar));
				o1->nast->poprz = o1;
				o1 = o1->nast;
				o1->nr_pomiaru = el->nr_pomiaru;
				o1->nr_czujnika = el->nr_czujnika;
				strcpy(o1->data_i_czas, el->data_i_czas);
				o1->temp = el->temp;
				o1->nast = NULL;
			}
			break;
		case 2:
			if (g2 == NULL) {
				g2 = (struct pomiar*)malloc(sizeof(struct pomiar));
				o2 = g2;
				o2->nr_pomiaru = el->nr_pomiaru;
				o2->nr_czujnika = el->nr_czujnika;
				strcpy(o2->data_i_czas, el->data_i_czas);
				o2->temp = el->temp;
				o2->nast = NULL;
				o2->poprz = NULL;
			}
			else {
				o2->nast = (struct pomiar*)malloc(sizeof(struct pomiar));
				o2->nast->poprz = o2;
				o2 = o2->nast;
				o2->nr_pomiaru = el->nr_pomiaru;
				o2->nr_czujnika = el->nr_czujnika;
				strcpy(o2->data_i_czas, el->data_i_czas);
				o2->temp = el->temp;
				o2->nast = NULL;
			}
			break;
		case 3:
			if (g3 == NULL) {
				g3 = (struct pomiar*)malloc(sizeof(struct pomiar));
				o3 = g3;
				o3->nr_pomiaru = el->nr_pomiaru;
				o3->nr_czujnika = el->nr_czujnika;
				strcpy(o3->data_i_czas, el->data_i_czas);
				o3->temp = el->temp;
				o3->nast = NULL;
				o3->poprz = NULL;
			}
			else {
				o3->nast = (struct pomiar*)malloc(sizeof(struct pomiar));
				o3->nast->poprz = o3;
				o3 = o3->nast;
				o3->nr_pomiaru = el->nr_pomiaru;
				o3->nr_czujnika = el->nr_czujnika;
				strcpy(o3->data_i_czas, el->data_i_czas);
				o3->temp = el->temp;
				o3->nast = NULL;
			}
			break;
		case 4:
			if (g4 == NULL) {
				g4 = (struct pomiar*)malloc(sizeof(struct pomiar));
				o4 = g4;
				o4->nr_pomiaru = el->nr_pomiaru;
				o4->nr_czujnika = el->nr_czujnika;
				strcpy(o4->data_i_czas, el->data_i_czas);
				o4->temp = el->temp;
				o4->nast = NULL;
				o4->poprz = NULL;
			}
			else {
				o4->nast = (struct pomiar*)malloc(sizeof(struct pomiar));
				o4->nast->poprz = o4;
				o4 = o4->nast;
				o4->nr_pomiaru = el->nr_pomiaru;
				o4->nr_czujnika = el->nr_czujnika;
				strcpy(o4->data_i_czas, el->data_i_czas);
				o4->temp = el->temp;
				o4->nast = NULL;
			}
			break;
		}
		el = el->nast;
	}
	d.g1 = g1; d.g2 = g2; d.g3 = g3; d.g4 = g4;
	return d;
}
struct pomiar* czwarta(struct pomiar* glowa) {
	struct pomiar* max = znajdz_max(glowa);
	struct pomiar* min = znajdz_min(glowa);
	printf("\nMAX: %d %d %s %lf\n", max->nr_pomiaru,max->nr_czujnika,max->data_i_czas, max->temp);
	printf("MIN: %d %d %s %lf\n",min->nr_pomiaru, min->nr_czujnika, min->data_i_czas, min->temp);
	struct pomiar* pom = glowa;
	while (pom->nast != NULL) {
		pom = pom->nast;
	}
	struct pomiar* ogon = NULL;
	pom->nast = (struct pomiar*)malloc(sizeof(struct pomiar));
	ogon = pom->nast;
	ogon->nr_pomiaru = max->nr_pomiaru;
	ogon->nr_czujnika = max->nr_czujnika;
	strcpy(ogon->data_i_czas, max->data_i_czas);
	ogon->temp = max->temp;
	ogon->nast = (struct pomiar*)malloc(sizeof(struct pomiar));
	ogon = ogon->nast;
	ogon->nr_pomiaru = min->nr_pomiaru;
	ogon->nr_czujnika = min->nr_czujnika;
	strcpy(ogon->data_i_czas, min->data_i_czas);
	ogon->temp = min->temp;
	ogon->nast = NULL;
	return glowa;
}
void piata(struct pomiar *glowa) {
	double old_temp = glowa->temp;
	struct pomiar* el = glowa->nast;
	while (el->nast != NULL) {
		if ((old_temp > el->temp && el->temp > el->nast->temp)||(el->nast->temp > el->temp && el->temp > old_temp)) {
			//srodkowa
			old_temp = el->temp;
		}
		else if ((el->temp > old_temp && old_temp > el->nast->temp) || (el->nast->temp > old_temp && old_temp > el->temp)) {
			//lewa
			double pom = el->temp;
			el->temp = old_temp;
			old_temp = pom;
		}
		else if ((el->temp > el->nast->temp&& el->nast->temp > old_temp) || (old_temp > el->nast->temp && el->nast->temp > el->temp)) {
			//prawa
			old_temp = el->temp;
			el->temp = el->nast->temp;
		}
		el = el->nast;
	}
}
int main() {
	char fname1[SIZE] = { 0 };
	char fname2[SIZE] = { 0 };
	char fname3[SIZE] = { 0 };
	printf("\nNazwa pliku we: \n");
	strcpy(fname1, "temp-na-zewn.txt");// scanf("%s", &fname1);
	struct pomiar* glowa = wczytaj(fname1);
	druga(glowa);
	struct d_pomiar d = trzecia(glowa);
	struct pomiar* pom = NULL;
	while (glowa != NULL) {
		pom = glowa;
		glowa = glowa->nast;
		free(pom);
	}
	printf("\nG1:\n");
	druga(d.g1);
	d.g1 = czwarta(d.g1);
	druga(d.g1);
	printf("\nG2:\n");
	druga(d.g2);
	d.g2 = czwarta(d.g2);
	druga(d.g2);
	printf("\nG3:\n");
	druga(d.g3);
	d.g3 = czwarta(d.g3);
	druga(d.g3);
	printf("\nG4:\n");
	druga(d.g4);
	d.g4 = czwarta(d.g4);
	druga(d.g4);

	
	//Zapis do plikow
	printf("\nNazwa pliku wy (bez typu pliku): ");
	strcpy(fname2, "wy");// scanf("%s", &fname2);
	FILE *out = NULL;
	strcpy(fname3, fname2);
	strcat(fname3, "PRZED.txt");
	out = fopen(fname3, "w");
	pom = d.g2;
	while (pom != NULL) {
		fprintf(out, "%d %d %s %lf\n", pom->nr_pomiaru, pom->nr_czujnika, pom->data_i_czas, pom->temp);
		pom = pom->nast;
	}

	piata(d.g2);

	strcpy(fname3, fname2);
	strcat(fname3, "PO.txt");
	out = fopen(fname3, "w");
	pom = d.g2;
	while (pom != NULL) {
		fprintf(out, "%d %d %s %lf\n", pom->nr_pomiaru, pom->nr_czujnika, pom->data_i_czas, pom->temp);
		pom = pom->nast;
	}
	//Dealokuj
	while (d.g1 != NULL) {
		pom = d.g1;
		d.g1 = d.g1->nast;
		free(pom);
	}
	while (d.g2 != NULL) {
		pom = d.g2;
		d.g2 = d.g2->nast;
		free(pom);
	}
	while (d.g3 != NULL) {
		pom = d.g3;
		d.g3 = d.g3->nast;
		free(pom);
	}
	while (d.g4 != NULL) {
		pom = d.g4;
		d.g4 = d.g4->nast;
		free(pom);
	}

	return 0;
}
